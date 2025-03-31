Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 217A8C3600B
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Mar 2025 15:01:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D903840650;
	Mon, 31 Mar 2025 17:01:38 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 69F5C402DF
 for <dev@dpdk.org>; Mon, 31 Mar 2025 17:01:37 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 64D1E464CA; Mon, 31 Mar 2025 17:01:37 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/vhost/virtio Bug 1685] [dpdk-22.11.8RC1]
 virtio_ipsec_cryptodev_func/test_aesni_mb_aes_cbc_sha1_hmac: 
 dpdk-vhost_crypto Segmentation fault (core dumped)  when launch qemu
Date: Mon, 31 Mar 2025 15:01:37 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: vhost/virtio
X-Bugzilla-Version: 22.11
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: luca.boccassi@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: FIXED
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: resolution bug_status
Message-ID: <bug-1685-3-hiMjfOa0CZ@http.bugs.dpdk.org/>
In-Reply-To: <bug-1685-3@http.bugs.dpdk.org/>
References: <bug-1685-3@http.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17434332970.16C3.380025
Content-Transfer-Encoding: 7bit
X-Bugzilla-URL: http://bugs.dpdk.org/
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


--17434332970.16C3.380025
Date: Mon, 31 Mar 2025 17:01:37 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: http://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1685

Luca Boccassi (luca.boccassi@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
         Resolution|---                         |FIXED
             Status|UNCONFIRMED                 |RESOLVED

--- Comment #3 from Luca Boccassi (luca.boccassi@gmail.com) ---
Fixed by reverting, thanks

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17434332970.16C3.380025
Date: Mon, 31 Mar 2025 17:01:37 +0200
MIME-Version: 1.0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: http://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

<html>
    <head>
      <base href=3D"https://bugs.dpdk.org/">
    </head>
    <body><span class=3D"vcard"><a class=3D"email" href=3D"mailto:luca.bocc=
assi&#64;gmail.com" title=3D"Luca Boccassi (luca.boccassi&#64;gmail.com)"> =
<span class=3D"fn">Luca Boccassi</span></a>
</span> changed
          <a class=3D"bz_bug_link=20
          bz_status_RESOLVED  bz_closed"
   title=3D"RESOLVED FIXED - [dpdk-22.11.8RC1] virtio_ipsec_cryptodev_func/=
test_aesni_mb_aes_cbc_sha1_hmac: dpdk-vhost_crypto Segmentation fault (core=
 dumped) when launch qemu"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1685">bug 1685</a>
          <br>
             <table border=3D"1" cellspacing=3D"0" cellpadding=3D"8" class=
=3D"bz_diff_table">
          <tr>
            <th>What</th>
            <th>Removed</th>
            <th>Added</th>
          </tr>

         <tr>
           <td style=3D"text-align:right;">Resolution</td>
           <td>---
           </td>
           <td>FIXED
           </td>
         </tr>

         <tr>
           <td style=3D"text-align:right;">Status</td>
           <td>UNCONFIRMED
           </td>
           <td>RESOLVED
           </td>
         </tr></table>
      <p>
        <div class=3D"bz_comment_block">
            <b class=3D"bz_comment_head"><a class=3D"bz_bug_link=20
          bz_status_RESOLVED  bz_closed"
   title=3D"RESOLVED FIXED - [dpdk-22.11.8RC1] virtio_ipsec_cryptodev_func/=
test_aesni_mb_aes_cbc_sha1_hmac: dpdk-vhost_crypto Segmentation fault (core=
 dumped) when launch qemu"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1685#c3">Comment # 3</a>
              on <a class=3D"bz_bug_link=20
          bz_status_RESOLVED  bz_closed"
   title=3D"RESOLVED FIXED - [dpdk-22.11.8RC1] virtio_ipsec_cryptodev_func/=
test_aesni_mb_aes_cbc_sha1_hmac: dpdk-vhost_crypto Segmentation fault (core=
 dumped) when launch qemu"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1685">bug 1685</a>
              from <span class=3D"vcard"><a class=3D"email" href=3D"mailto:=
luca.boccassi&#64;gmail.com" title=3D"Luca Boccassi (luca.boccassi&#64;gmai=
l.com)"> <span class=3D"fn">Luca Boccassi</span></a>
</span>
            </b>
          <pre class=3D"bz_comment_text">Fixed by reverting, thanks
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
?id=3D1685#c3">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17434332970.16C3.380025--
