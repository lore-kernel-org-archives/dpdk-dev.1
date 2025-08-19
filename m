Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95720CA0EE4
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 Aug 2025 01:33:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6C88F40430;
	Tue, 19 Aug 2025 03:33:30 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 85BE6402E4
 for <dev@dpdk.org>; Tue, 19 Aug 2025 03:33:29 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 61E6746D5F; Tue, 19 Aug 2025 03:33:29 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/cryptodev Bug 1773] Crypto devices should be using constant
 time memcmp
Date: Tue, 19 Aug 2025 01:33:28 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: cryptodev
X-Bugzilla-Version: 25.07
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
Message-ID: <bug-1773-3@https.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17555672090.8BbEda.44146
Content-Transfer-Encoding: 7bit
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


--17555672090.8BbEda.44146
Date: Tue, 19 Aug 2025 03:33:28 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1773

            Bug ID: 1773
           Summary: Crypto devices should be using constant time memcmp
           Product: DPDK
           Version: 25.07
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: cryptodev
          Assignee: dev@dpdk.org
          Reporter: stephen@networkplumber.org
  Target Milestone: ---

To be resistant to timing attacks all cryptodev operations should be using a
version of memcmp that takes constant time.

There is no such function in std libc maybe make a new one?

Examples in current code base:


~/.../main/drivers/crypto $ git grep memcmp
armv8/rte_armv8_pmd.c:          if (memcmp(adst, op->sym->auth.digest.data,
ccp/ccp_crypto.c:               if (memcmp(dst, op->sym->auth.digest.data,
ccp/ccp_crypto.c:               if (memcmp(addr + offset, digest_data,
cnxk/cnxk_ae.h:         if (memcmp(rsa->sign.data, rsa->message.data,
cnxk/cnxk_se.h: if (memcmp(mac, gen_mac, mac_len))
ipsec_mb/pmd_aesni_gcm.c:               if (memcmp(tag, digest,
session->req_digest_length) !=3D 0)
ipsec_mb/pmd_aesni_gcm.c:       return memcmp(digest, tmpdigest,
s->req_digest_length) =3D=3D 0 ? 0
ipsec_mb/pmd_aesni_mb.c:        if (memcmp(job->auth_tag_output, crc,
RTE_ETHER_CRC_LEN) !=3D 0)
ipsec_mb/pmd_aesni_mb.c:        if (memcmp(job->auth_tag_output, digest, le=
n)
!=3D 0)
ipsec_mb/pmd_aesni_mb.c:                        if (memcmp(vec->digest[i].v=
a,
dgst[i], len) !=3D 0)
ipsec_mb/pmd_snow3g.c:                  if (memcmp(dst,
ops[i]->sym->auth.digest.data,
ipsec_mb/pmd_zuc.c:                     if (memcmp(dst[i],
ops[i]->sym->auth.digest.data,
mlx5/mlx5_crypto_dek.c: return memcmp(key, dek->data, xkey_len);
nitrox/nitrox_sym_reqmgr.c:     if (!memcmp(ctx->salt, addr,
AES_GCM_SALT_SIZE))
octeontx/otx_cryptodev_ops.c:           if (memcmp(rsa->sign.data,
rsa->message.data,
openssl/rte_openssl_pmd.c:              if (CRYPTO_memcmp(dst,
op->sym->auth.digest.data,
openssl/rte_openssl_pmd.c:              if (CRYPTO_memcmp(tmp,
op->rsa.message.data,
openssl/rte_openssl_pmd.c:              if ((ret <=3D 0) || (CRYPTO_memcmp(=
tmp,
op->rsa.message.data,
scheduler/rte_cryptodev_scheduler.c:            return
!memcmp(&sec_cap1->docsis, &sec_cap2->docsis,
uadk/uadk_crypto_pmd.c:                 if (memcmp(dst,
op->sym->auth.digest.data,

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17555672090.8BbEda.44146
Date: Tue, 19 Aug 2025 03:33:29 +0200
MIME-Version: 1.0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

<html>
    <head>
      <base href=3D"https://bugs.dpdk.org/">
    </head>
    <body><table border=3D"1" cellspacing=3D"0" cellpadding=3D"8" class=3D"=
bz_new_table">
        <tr>
          <th>Bug ID</th>
          <td><a class=3D"bz_bug_link=20
          bz_status_UNCONFIRMED "
   title=3D"UNCONFIRMED - Crypto devices should be using constant time memc=
mp"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1773">1773</a>
          </td>
        </tr>

        <tr>
          <th>Summary</th>
          <td>Crypto devices should be using constant time memcmp
          </td>
        </tr>

        <tr>
          <th>Product</th>
          <td>DPDK
          </td>
        </tr>

        <tr>
          <th>Version</th>
          <td>25.07
          </td>
        </tr>

        <tr>
          <th>Hardware</th>
          <td>All
          </td>
        </tr>

        <tr>
          <th>OS</th>
          <td>All
          </td>
        </tr>

        <tr>
          <th>Status</th>
          <td>UNCONFIRMED
          </td>
        </tr>

        <tr>
          <th>Severity</th>
          <td>normal
          </td>
        </tr>

        <tr>
          <th>Priority</th>
          <td>Normal
          </td>
        </tr>

        <tr>
          <th>Component</th>
          <td>cryptodev
          </td>
        </tr>

        <tr>
          <th>Assignee</th>
          <td>dev&#64;dpdk.org
          </td>
        </tr>

        <tr>
          <th>Reporter</th>
          <td>stephen&#64;networkplumber.org
          </td>
        </tr>

        <tr>
          <th>Target Milestone</th>
          <td>---
          </td>
        </tr></table>
      <p>
        <div class=3D"bz_comment_block">
          <pre class=3D"bz_comment_text">To be resistant to timing attacks =
all cryptodev operations should be using a
version of memcmp that takes constant time.

There is no such function in std libc maybe make a new one?

Examples in current code base:


~/.../main/drivers/crypto $ git grep memcmp
armv8/rte_armv8_pmd.c:          if (memcmp(adst, op-&gt;sym-&gt;auth.digest=
.data,
ccp/ccp_crypto.c:               if (memcmp(dst, op-&gt;sym-&gt;auth.digest.=
data,
ccp/ccp_crypto.c:               if (memcmp(addr + offset, digest_data,
cnxk/cnxk_ae.h:         if (memcmp(rsa-&gt;sign.data, rsa-&gt;message.data,
cnxk/cnxk_se.h: if (memcmp(mac, gen_mac, mac_len))
ipsec_mb/pmd_aesni_gcm.c:               if (memcmp(tag, digest,
session-&gt;req_digest_length) !=3D 0)
ipsec_mb/pmd_aesni_gcm.c:       return memcmp(digest, tmpdigest,
s-&gt;req_digest_length) =3D=3D 0 ? 0
ipsec_mb/pmd_aesni_mb.c:        if (memcmp(job-&gt;auth_tag_output, crc,
RTE_ETHER_CRC_LEN) !=3D 0)
ipsec_mb/pmd_aesni_mb.c:        if (memcmp(job-&gt;auth_tag_output, digest,=
 len)
!=3D 0)
ipsec_mb/pmd_aesni_mb.c:                        if (memcmp(vec-&gt;digest[i=
].va,
dgst[i], len) !=3D 0)
ipsec_mb/pmd_snow3g.c:                  if (memcmp(dst,
ops[i]-&gt;sym-&gt;auth.digest.data,
ipsec_mb/pmd_zuc.c:                     if (memcmp(dst[i],
ops[i]-&gt;sym-&gt;auth.digest.data,
mlx5/mlx5_crypto_dek.c: return memcmp(key, dek-&gt;data, xkey_len);
nitrox/nitrox_sym_reqmgr.c:     if (!memcmp(ctx-&gt;salt, addr,
AES_GCM_SALT_SIZE))
octeontx/otx_cryptodev_ops.c:           if (memcmp(rsa-&gt;sign.data,
rsa-&gt;message.data,
openssl/rte_openssl_pmd.c:              if (CRYPTO_memcmp(dst,
op-&gt;sym-&gt;auth.digest.data,
openssl/rte_openssl_pmd.c:              if (CRYPTO_memcmp(tmp,
op-&gt;rsa.message.data,
openssl/rte_openssl_pmd.c:              if ((ret &lt;=3D 0) || (CRYPTO_memc=
mp(tmp,
op-&gt;rsa.message.data,
scheduler/rte_cryptodev_scheduler.c:            return
!memcmp(&amp;sec_cap1-&gt;docsis, &amp;sec_cap2-&gt;docsis,
uadk/uadk_crypto_pmd.c:                 if (memcmp(dst,
op-&gt;sym-&gt;auth.digest.data,
          </pre>
        </div>
      </p>


      <hr>
      <span>You are receiving this mail because:</span>

      <ul>
          <li>You are the assignee for the bug.</li>
      </ul>
      <div itemscope itemtype=3D"http://schema.org/EmailMessage">
        <div itemprop=3D"action" itemscope itemtype=3D"http://schema.org/Vi=
ewAction">
=20=20=20=20=20=20=20=20=20=20
          <link itemprop=3D"url" href=3D"https://bugs.dpdk.org/show_bug.cgi=
?id=3D1773">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17555672090.8BbEda.44146--
