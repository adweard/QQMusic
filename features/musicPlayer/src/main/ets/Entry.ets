export interface LrcEntry {
  /**
   * The start time of this line of lyrics. Unit: ms.
   */
  lineStartTime: number;


   // The duration of this line of lyrics. Unit: ms.

  lineDuration: number;

  /**
   * This Line lyrics.
   */
  lineWords: string;

}