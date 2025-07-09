Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45490C83F09
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Jul 2025 12:58:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8FED9402DA;
	Wed,  9 Jul 2025 14:58:30 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 9D99F402A9;
 Wed,  9 Jul 2025 14:58:29 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 66D25204A9;
 Wed,  9 Jul 2025 14:58:29 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: [PATCH] doc: announce changes in structure alignments for UBSan
Content-Transfer-Encoding: quoted-printable
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Wed, 9 Jul 2025 14:58:27 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FDA9@smartserver.smartshare.dk>
In-Reply-To: <20250709124022.4105481-1-david.marchand@redhat.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] doc: announce changes in structure alignments for UBSan
Thread-Index: AdvwzrBgDJZ/uSIkRk2QRded6vkRvQAAlaig
References: <20250709124022.4105481-1-david.marchand@redhat.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "David Marchand" <david.marchand@redhat.com>,
	<dev@dpdk.org>
Cc: <thomas@monjalon.net>,
	<techboard@dpdk.org>
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

> From: David Marchand [mailto:david.marchand@redhat.com]
> Sent: Wednesday, 9 July 2025 14.40
>=20
> As part of the effort to limit undefined behaviors in DPDK code, some
> structure alignments revealed not to be accurate enough.
> At the moment two structures have been identified but others may be
> found while running more parts of DPDK with UBSan.
>=20
> Though the calling code can explicitly request alignment,
> we would prefer to put the alignment constraints as part of the
> structure definition itself.
>=20
> Such changes are ABI breakages.
>=20
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
>  doc/guides/rel_notes/deprecation.rst | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/doc/guides/rel_notes/deprecation.rst
> b/doc/guides/rel_notes/deprecation.rst
> index e2d4125308..4ae561d670 100644
> --- a/doc/guides/rel_notes/deprecation.rst
> +++ b/doc/guides/rel_notes/deprecation.rst
> @@ -57,6 +57,10 @@ Deprecation Notices
>    ``__atomic_thread_fence`` must be used for patches that need to be
> merged in
>    20.08 onwards. This change will not introduce any performance
> degradation.
>=20
> +* lib: multiple issues relating to unaligned accesses have been
> detected using the UBSan checker.
> +  As part of resolving those issues, alignment in some structures =
will
> be updated in 25.11,
> +  namely (but not exhaustively): ``struct rte_stack_lf_head`` and
> ``struct rte_mp_msg``.
> +
>  * lib: will fix extending some enum/define breaking the ABI. There =
are
> multiple
>    samples in DPDK that enum/define terminated with a ``.*MAX.*`` =
value
> which is
>    used by iterators, and arrays holding these values are sized with
> this
> --
> 2.50.0

Yes, please.

Acked-by: Morten Br=F8rup <mb@smartsharesystems.com>

