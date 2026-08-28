Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7569C61DB9
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Aug 2026 09:09:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D4DF64025A;
	Fri, 28 Aug 2026 11:09:44 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id BDD5B40150
 for <dev@dpdk.org>; Fri, 28 Aug 2026 11:09:43 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id AD5534D08E; Fri, 28 Aug 2026 11:09:43 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/cryptodev Bug 1987] OpenSSL AES-128-CBC encryption with
 scatter-gather buffer overflow
Date: Fri, 28 Aug 2026 09:09:43 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: cryptodev
X-Bugzilla-Version: unspecified
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: thomas@monjalon.net
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone bug_group
Message-ID: <bug-1987-3@https.bugs.dpdk.org/>
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

https://bugs.dpdk.org/show_bug.cgi?id=3D1987

            Bug ID: 1987
           Summary: OpenSSL AES-128-CBC encryption with scatter-gather
                    buffer overflow
           Product: DPDK
           Version: unspecified
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: cryptodev
          Assignee: dev@dpdk.org
          Reporter: thomas@monjalon.net
  Target Milestone: ---
             Group: security

Report date: 2025-02-20
Reported by: Gowtham Suresh Kumar <Gowtham.SureshKumar@arm.com>

Subject: Security Vulnerability: Buffer Overflow in DPDK function
process_openssl_encryption_update() for segmented in-place operations

Dear DPDK Security Team,

I would like to report a buffer overflow vulnerability in DPDK that occurs =
in
AES-128-CBC Encryption with Scatter-Gather, Inplace configuration for a
particular corner case. This issue leads to out-of-bounds writes, potential=
ly
overwriting sensitive information such as plaintext or ciphertext outside t=
he
allocated buffer.
Issue Description:

The vulnerability can be reproduced by modifying sgl_segs parameter in
AES-128-CBC Encryption Scatter-Gather (Inplace) test case increasing the
segment count from 3 to 128, in test_cryptodev_aes_test_vectors.h. When usi=
ng
small segment sizes (e.g., 4 bytes per segment), incorrect pointer handling
results in OpenSSL writing ciphertext outside the expected buffer bounds.

Key Findings:
- Incorrect Pointer Updates: The dst pointer is updated incorrectly across
consecutive EVP_EncryptUpdate() calls, even when OpenSSL buffers input inst=
ead
of producing immediate ciphertext.
- Buffer Overflow in EVP_Final(): When OpenSSL finally encrypts the accumul=
ated
data, it writes beyond the allocated buffer, overwriting adjacent memory.
- Segment Size Dependency: The issue occurs for small segment sizes
specifically when sizes of consecutive segments together is smaller than bl=
ock
size of the cipher

Root Cause Analysis:
- dst pointer is updated incorrectly even when OpenSSL does not generate ou=
tput
(outl =3D 0).
- Small segments cause OpenSSL to delay encryption, leading to misalignment=
 in
buffer usage.
- On final encryption (EVP_Final()), OpenSSL writes ciphertext at an incorr=
ect
memory location, causing a buffer overflow.

Impact & Security Concerns:
This issue presents a critical security risk, as it allows OpenSSL to:
- Write sensitive plaintext or ciphertext outside the allocated buffer,
potentially exposing cryptographic data.
- Corrupt adjacent memory, leading to unpredictable behavior or crashes.
- Introduce vulnerabilities that could be exploited depending on the deploy=
ment
context.

Proposed Fix:
- Modify process_openssl_encryption_update() to ensure dst pointer is updat=
ed
only when valid ciphertext is produced.
- Introduce additional checks to prevent buffer overflows when segment sizes
are small.
- Expand test cases to include non-block-aligned segment sizes to detect
similar issues.

--=20
You are receiving this mail because:
You are the assignee for the bug.=
