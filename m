Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A25C61DBD
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Aug 2026 09:41:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 52A4240151;
	Fri, 28 Aug 2026 11:41:01 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id C722940150
 for <dev@dpdk.org>; Fri, 28 Aug 2026 11:40:59 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id B24324D082; Fri, 28 Aug 2026 11:40:59 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/cryptodev Bug 1991] CN10K inline IPsec oversized key
Date: Fri, 28 Aug 2026 09:40:59 +0000
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
Message-ID: <bug-1991-3@https.bugs.dpdk.org/>
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

https://bugs.dpdk.org/show_bug.cgi?id=3D1991

            Bug ID: 1991
           Summary: CN10K inline IPsec oversized key
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

Report date: 2026-03-10
Reported by: =E4=BE=AF=E6=9C=8B=E6=9C=8B <pengpeng@iscas.ac.cn>

&nbsp; Dear DPDK Security Team,


&nbsp; I am reporting a security vulnerability discovered in the cnxk poll =
mode
driver, specifically affecting the CN10K inline IPsec implementation. This =
is
an intra-object
&nbsp; overflow where a lack of key length validation allows an oversized
crypto key to overwrite adjacent members in the Security Association (SA)
structure.


&nbsp; Vulnerability Overview
&nbsp; The vulnerability occurs during the creation of an inline IPsec sess=
ion.
The cn10k driver fails to validate the encryption/authentication key length
against its internal
&nbsp; buffer size in the inline path, leading to a memory overwrite when
calling shared helper functions.


&nbsp; Technical Analysis
&nbsp; 1. The Bypass (The Root Cause):
&nbsp; In drivers/net/cnxk/cn10k_ethdev_sec.c, the function
cn10k_eth_sec_session_create() is responsible for setting up security sessi=
ons.
Unlike the lookaside crypto path, this
&nbsp; inline Ethernet path does not invoke cnxk_ipsec_xform_verify(), whic=
h is
supposed to gate invalid algorithm/length combinations.


&nbsp; 2. The Sink (The Overflow Point):
&nbsp; The session creation flows into the shared helper
ot_ipsec_sa_common_param_fill() located in drivers/common/cnxk/cnxk_securit=
y.c:




&nbsp; &nbsp;1 ot_ipsec_sa_common_param_fill(..., uint8_t *cipher_key, ...)=
 {
&nbsp; &nbsp;2&nbsp; &nbsp; &nbsp;...
&nbsp; &nbsp;3&nbsp; &nbsp; &nbsp;if (key !=3D NULL &amp;&amp; length !=3D =
0) {
&nbsp; &nbsp;4&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;/* Copy encryption key */
&nbsp; &nbsp;5&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;memcpy(cipher_key, key,
length); // OVERFLOW SINK
&nbsp; &nbsp;6&nbsp; &nbsp; &nbsp;}
&nbsp; &nbsp;7&nbsp; &nbsp; &nbsp;...
&nbsp; &nbsp;8 }




&nbsp; Here, length is the value provided by the application via
rte_security_session_conf.crypto_xform-&gt;cipher.key.length.


&nbsp; 3. The Object Layout:
&nbsp; The cipher_key pointer provided to the helper points to a fixed-size
array within struct roc_ot_ipsec_inb_sa (or outb_sa):




&nbsp; &nbsp; 1 struct roc_ot_ipsec_inb_sa {
&nbsp; &nbsp; 2&nbsp; &nbsp; &nbsp;...
&nbsp; &nbsp; 3&nbsp; &nbsp; &nbsp;uint8_t cipher_key[32]; // Fixed size
ROC_CTX_MAX_CKEY_LEN
&nbsp; &nbsp; 4&nbsp; &nbsp; &nbsp;union {
&nbsp; &nbsp; 5&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;struct {
&nbsp; &nbsp; 6&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;uint32_t rsv=
d8;
&nbsp; &nbsp; 7&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;uint8_t salt=
[4];
&nbsp; &nbsp; 8&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;} s;
&nbsp; &nbsp; 9&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;uint64_t u64;
&nbsp; &nbsp;10&nbsp; &nbsp; &nbsp;} w8;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;// Adjacent member
&nbsp; &nbsp;11&nbsp; &nbsp; &nbsp;...
&nbsp; &nbsp;12 };




&nbsp; 4. The Exploitation Scenario (e.g., 3DES):
&nbsp; If an application requests RTE_CRYPTO_CIPHER_3DES_CBC but provides a=
 key
length of 40 bytes (which is invalid for 3DES but not rejected by the common
helper for non-AES
&nbsp; algorithms):
&nbsp; &nbsp;- The first 32 bytes fill cipher_key.
&nbsp; &nbsp;- The remaining 8 bytes overwrite the w8 union, which contains=
 the
live salt value used for the IPsec transformation.




&nbsp; For AES-GMAC algorithms, the helper does have a switch(length) check,
but it occurs after the memcpy has already been executed, meaning the overf=
low
happens even if the
&nbsp; function eventually returns -EINVAL.




&nbsp; Impact
&nbsp; This vulnerability allows the corruption of internal SA metadata. In=
 a
production environment where security session parameters might be influence=
d by
external
&nbsp; configurations, this can lead to:
&nbsp; &nbsp;- Cryptographic Failure: Manipulation of IVs or Salt values.
&nbsp; &nbsp;- Denial of Service: Triggering unexpected driver behavior or
crashes due to corrupted SA state.
&nbsp; &nbsp;- Information Leakage: If the IV generation logic relies on the
corrupted memory area.




&nbsp; Suggested Mitigation
&nbsp; &nbsp;1. Ensure cnxk_ipsec_xform_verify() is called in the
cn10k_eth_sec_session_create path before any SA filling occurs.
&nbsp; &nbsp;2. Add explicit bounds checking in ot_ipsec_sa_common_param_fi=
ll()
to ensure length never exceeds ROC_CTX_MAX_CKEY_LEN (32 bytes) before the
memcpy is executed.

--=20
You are receiving this mail because:
You are the assignee for the bug.=
