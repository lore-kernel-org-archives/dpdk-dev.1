Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2376606A329
	for <dpdk-dev@archiver.kernel.org>; Sat, 14 Nov 2026 17:37:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 901684025A;
	Sat, 14 Nov 2026 18:37:47 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTPS id 60E694021E
 for <dev@dpdk.org>; Sat, 14 Nov 2026 18:37:46 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 4E6EF4C18B; Sat, 14 Nov 2026 18:37:46 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/cryptodev Bug 2126]
 drivers/crypto/openssl/rte_openssl_pmd.c:2268 in process_openssl_modexp_op()
Date: Sat, 14 Nov 2026 17:37:46 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: cryptodev
X-Bugzilla-Version: 26.11
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: stephen@networkplumber.org
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-2126-3@https.bugs.dpdk.org/>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
X-Bugzilla-URL: https://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

https://bugs.dpdk.org/show_bug.cgi?id=3D2126

            Bug ID: 2126
           Summary: drivers/crypto/openssl/rte_openssl_pmd.c:2268  in
                    process_openssl_modexp_op()
           Product: DPDK
           Version: 26.11
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: cryptodev
          Assignee: dev@dpdk.org
          Reporter: stephen@networkplumber.org
  Target Milestone: ---

Reported-by Anthropic OSS Scanner ANT-2026-71V1RCLL

Every modexp and modinv op processed by the `crypto_openssl` PMD permanently
adds two BIGNUMs to the session's `BN_CTX`. A long-lived session therefore
grows the process heap by a fixed amount per op (1124 bytes per 2048-bit
modexp, 628 per modinv) until the session is freed. An application that kee=
ps
one of these sessions and runs many ops on it will eventually see ops compl=
ete
with `RTE_CRYPTO_OP_STATUS_ERROR` once allocation fails inside `BN_mod_exp(=
)`,
or the kernel kills the process if no memory limit is set.

The cause is in `process_openssl_modexp_op()` and `process_openssl_modinv_o=
p()`
in `drivers/crypto/openssl/rte_openssl_pmd.c`. Each calls `BN_CTX_get()` tw=
ice
on the session context without its own `BN_CTX_start()`/`BN_CTX_end()` pair.
The only open frame on that context is the one
`openssl_set_asym_session_parameters()` opens at session creation, and
`openssl_reset_asym_session()` closes it at session release, so every op ta=
kes
two new entries from the pool and none are ever reused. `BN_clear()` only
zeroes the values. The default build is affected, no special input is invol=
ved,
and ASan/LSan report nothing because the memory is released with the sessio=
n.
The attached reproducer runs 2 =C3=97 10000 modexp ops on one session and s=
hows
about 11 MB of growth per batch, nearly all of it returned by
`rte_cryptodev_asym_session_free()`. `dpdk-test-crypto-perf --optype modex
--total-ops 1000000` peaks around 631 MiB RSS for the same reason. The atta=
ched
patch wraps each op in its own nested `BN_CTX_start()`/`BN_CTX_end()` frame,
which brings per-op growth to zero. It would carry `Fixes: 3e9d6bd447fb` and
`Cc: stable`, like the earlier per-op leak fixes in this driver.

This is an ordinary bug, not a security issue: the ops that trigger it are
well-formed, nothing in DPDK lets an
outside party drive modexp or modinv ops on a `crypto_openssl` session, and=
 an
application's own ordinary load hits
it just the same.

#

--=20
You are receiving this mail because:
You are the assignee for the bug.=
