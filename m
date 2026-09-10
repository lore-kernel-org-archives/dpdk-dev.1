Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D1FC79FB9
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Sep 2026 12:15:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C8C0D410DC;
	Thu, 10 Sep 2026 14:15:56 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 2D4A14028F
 for <dev@dpdk.org>; Thu, 10 Sep 2026 14:15:55 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 211A94CDE9; Thu, 10 Sep 2026 14:15:55 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/other Bug 2033] pipeline: stack buffer overflow via strcat in
 spec parsing
Date: Thu, 10 Sep 2026 12:15:54 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: other
X-Bugzilla-Version: 26.03
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: yangshuaisong@h-partners.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-2033-3@https.bugs.dpdk.org/>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
X-Bugzilla-URL: https://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All
MIME-Version: 1.0
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

https://bugs.dpdk.org/show_bug.cgi?id=3D2033

            Bug ID: 2033
           Summary: pipeline: stack buffer overflow via strcat in spec
                    parsing
           Product: DPDK
           Version: 26.03
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: other
          Assignee: dev@dpdk.org
          Reporter: yangshuaisong@h-partners.com
  Target Milestone: ---

[Overview]
A stack-based buffer overflow vulnerability exists in the DPDK pipeline lib=
rary
during the parsing of pipeline specification (.spec) files. The functions
`action_block_parse()` and `apply_block_parse()` in
`lib/pipeline/rte_swx_pipeline_spec.c` concatenate tokens into a fixed-size
stack buffer without checking the accumulated length, leading to a memory
corruption or crash.

[Location]
- File: lib/pipeline/rte_swx_pipeline_spec.c
- Functions: `action_block_parse()` (lines 467-471) and `apply_block_parse(=
)`
(lines 2155-2158)
- Buffer: `char buffer[RTE_SWX_INSTRUCTION_SIZE]` (256 bytes)

[Environment & Build]
- DPDK Version: [Please enter the scanned DPDK version here, e.g., 23.11 /
24.11 / main]
- OS / Kernel: Generic / Linux
- Tool: Identified via static analysis / manual code review.

[Vulnerability Logic & Analysis]
1. The specification file parser loop (lines 2903-2952) restricts individual
token lengths to less than 64 bytes (`strnlen(token, RTE_SWX_NAME_SIZE) >=3D
RTE_SWX_NAME_SIZE` triggers "Token too big").
2. However, there is no upper-bound validation on the total accumulated len=
gth
of `n_tokens` within a single line. The maximum tokens per line (`MAX_TOKEN=
S`)
is 256, and the maximum line length (`MAX_LINE_LENGTH`) is 2048.
3. In `action_block_parse()` and `apply_block_parse()`, tokens are concaten=
ated
into a 256-byte stack buffer using unbounded `strcat`:
   ```c
   buffer =3D 0;
   for (i =3D 0; i < n_tokens; i++) {
       if (i)
           strcat(buffer, " ");
       strcat(buffer, tokens[i]);
   }
   ```
4. Mathematical Proof: If a malicious or malformed .spec file contains a li=
ne
with 5 tokens, each 63 bytes long, the total concatenated length becomes: 5=
 *
63 + 4 (spaces) =3D 319 bytes.
5. This mathematically exceeds the 255-byte capacity (256 bytes minus 1 null
terminator) of the stack buffer, leading to a definite stack buffer overflow
when processing such a file.

[Actual Results]
No runtime crash has been triggered yet, but static analysis confirms an
unvalidated path leading to a stack-based out-of-bounds write (CVE-2024-116=
16),
causing potential memory corruption or application crash if an oversized .s=
pec
file is loaded.

[Expected Results]
The token concatenation should safely handle string lengths, and the parser
should reject lines whose accumulated tokens exceed `RTE_SWX_INSTRUCTION_SI=
ZE -
1`.

[Suggested Fix]
Replace the unbounded `strcat` with bounded string operations (`strncat` or
`snprintf`) that consider the remaining space in the destination buffer, for
example:
```c
buffer =3D 0;
for (i =3D 0; i < n_tokens; i++) {
    if (i)
        strncat(buffer, " ", sizeof(buffer) - strlen(buffer) - 1);
    strncat(buffer, tokens[i], sizeof(buffer) - strlen(buffer) - 1);
}
```
Alternatively, add a pre-check validation on the total length before enteri=
ng
the concatenation loop, and return an error if it exceeds the limit.

--=20
You are receiving this mail because:
You are the assignee for the bug.=
