Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99EF0C282D0
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Mar 2025 01:07:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BE56C402A0;
	Wed,  5 Mar 2025 02:07:43 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id E9B5A40275
 for <dev@dpdk.org>; Wed,  5 Mar 2025 02:07:42 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id D570546346; Wed,  5 Mar 2025 02:07:42 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/cryptodev Bug 1669] Cannot use ESN with GMAC authentication
Date: Wed, 05 Mar 2025 01:07:42 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: cryptodev
X-Bugzilla-Version: unspecified
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: arieltraver@gmail.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1669-3@http.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17411368620.AD6Cd7.81541
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


--17411368620.AD6Cd7.81541
Date: Wed, 5 Mar 2025 02:07:42 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: http://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1669

            Bug ID: 1669
           Summary: Cannot use ESN with GMAC authentication
           Product: DPDK
           Version: unspecified
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: cryptodev
          Assignee: dev@dpdk.org
          Reporter: arieltraver@gmail.com
  Target Milestone: ---

Hi all,=20

I want to use NULL encryption and AES GMAC with an Extended Sequence Number
(ESN), but it seems like DPDK doesn't support doing so.

According to RFC 4303, only the lower-order 32 bits of an ESN are stored in=
 the
packet itself. The whole ESN is passed in separately, as part of the Additi=
onal
Authenticated Data (AAD).

DPDK allows you to set this AAD for AEAD encryption modes by adjusting
rte_crypto_op->sym->aead.aad.data and rte_crypto_op->sym->aead.aad.phys_add=
r.
However, DPDK treats AES GMAC as a separate authentication transform, not a=
s an
AEAD transform with null plaintext. If you aren't using AEAD encryption, th=
ere
doesn't seem to be any way to include AAD, either in the crypto op or in the
rte_crypto_auth_xform struct.=20

As such, you can't supply an ESN without including it in the packet itself,
which violates RFC 4303:2.2.1, or copying the whole packet + ESN to another
buffer just to authenticate.

I'm a new DPDK developer, so apologies if I misunderstood the situation. I =
did
my best to carefully read all of the crypto examples and even investigated =
the
implementation of some of the drivers to see how they handle AES GMAC. So f=
ar I
have found no clues.

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17411368620.AD6Cd7.81541
Date: Wed, 5 Mar 2025 02:07:42 +0100
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
    <body><table border=3D"1" cellspacing=3D"0" cellpadding=3D"8" class=3D"=
bz_new_table">
        <tr>
          <th>Bug ID</th>
          <td><a class=3D"bz_bug_link=20
          bz_status_UNCONFIRMED "
   title=3D"UNCONFIRMED - Cannot use ESN with GMAC authentication"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1669">1669</a>
          </td>
        </tr>

        <tr>
          <th>Summary</th>
          <td>Cannot use ESN with GMAC authentication
          </td>
        </tr>

        <tr>
          <th>Product</th>
          <td>DPDK
          </td>
        </tr>

        <tr>
          <th>Version</th>
          <td>unspecified
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
          <td>arieltraver&#64;gmail.com
          </td>
        </tr>

        <tr>
          <th>Target Milestone</th>
          <td>---
          </td>
        </tr></table>
      <p>
        <div class=3D"bz_comment_block">
          <pre class=3D"bz_comment_text">Hi all,=20

I want to use NULL encryption and AES GMAC with an Extended Sequence Number
(ESN), but it seems like DPDK doesn't support doing so.

According to RFC 4303, only the lower-order 32 bits of an ESN are stored in=
 the
packet itself. The whole ESN is passed in separately, as part of the Additi=
onal
Authenticated Data (AAD).

DPDK allows you to set this AAD for AEAD encryption modes by adjusting
rte_crypto_op-&gt;sym-&gt;aead.aad.data and rte_crypto_op-&gt;sym-&gt;aead.=
aad.phys_addr.
However, DPDK treats AES GMAC as a separate authentication transform, not a=
s an
AEAD transform with null plaintext. If you aren't using AEAD encryption, th=
ere
doesn't seem to be any way to include AAD, either in the crypto op or in the
rte_crypto_auth_xform struct.=20

As such, you can't supply an ESN without including it in the packet itself,
which violates RFC 4303:2.2.1, or copying the whole packet + ESN to another
buffer just to authenticate.

I'm a new DPDK developer, so apologies if I misunderstood the situation. I =
did
my best to carefully read all of the crypto examples and even investigated =
the
implementation of some of the drivers to see how they handle AES GMAC. So f=
ar I
have found no clues.
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
?id=3D1669">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17411368620.AD6Cd7.81541--
