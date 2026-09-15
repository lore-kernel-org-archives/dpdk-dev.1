Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F811C88E75
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 12:03:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8D8B642E56;
	Tue, 15 Sep 2026 14:02:23 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id A2D0A427E9
 for <dev@dpdk.org>; Tue, 15 Sep 2026 14:02:19 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id A2901206CA;
 Tue, 15 Sep 2026 14:02:18 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: Questions about RX checksum offload on virtio and vhost
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Tue, 15 Sep 2026 14:02:16 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65A46@smartserver.smartshare.dk>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Questions about RX checksum offload on virtio and vhost
Thread-Index: Ad1E+JpDcl4HCw1sRYyfc0Bes1ORXgAEOxOw
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Maxime Coquelin" <maxime.coquelin@redhat.com>
Cc: "David Marchand" <david.marchand@redhat.com>,
 "Harrison Caldicott" <harrison@itsfubar.com.au>, <dev@dpdk.org>
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

> From: Morten Br=F8rup
> Sent: Tuesday, 15 September 2026 11.57
>=20
> Hi Maxime,
>=20
> A Grout issue [1] regarding RX checksum offload with virtio and vhost
> triggered my curiosity...
>=20
> AFAIU, in Linux, the VIRTIO_NET_F_GUEST_CSUM flag on a virtio network
> device tells the host that it doesn't need to set the correct =
checksums
> in packets it writes to the device, because the guest will do it (when
> reading them).
>=20
> Now; if a guest application requests RTE_ETH_RX_OFFLOAD_CHECKSUM
> offload, the virtio PMD initializes the Linux device with
> VIRTIO_NET_F_GUEST_CSUM [2].
> This behavior seems counterintuitive to me...
> I would assume that if an application cares about packet checksums on
> ingress, it will set RTE_ETH_RX_OFFLOAD_CHECKSUM, so the NIC/PMD =
checks
> them, and the application can discard packets with invalid checksums =
on
> ingress.
> But the virtio PMD uses RTE_ETH_RX_OFFLOAD_CHECKSUM to disable
> checksums, not enable them?
>=20
> Two questions:
> 1. What is the use case for a guest application receiving packets
> without correct packet checksums from the virtio ports, which =
motivated
> this driver behavior?
> 2. What is the performance gain in the Linux host by not setting the
> checksums (enabling VIRTIO_NET_F_GUEST_CSUM)? (If the guest =
application
> needs to calculate them instead, the performance cost in the guest
> might outweigh the performance gain in the host not doing it when
> creating the packet in the Linux kernel.)
>=20
> NB: According to the Grout issue, the vhost PMD behaves similarly; but
> I haven't checked.
>=20
> [1]: https://github.com/DPDK/grout/issues/724
> [2]: =
https://github.com/DPDK/dpdk/blob/25.11/drivers/net/virtio/virtio_ethdev.=
c#L2282-L2284
>=20

I came across a patch [3], which writes into the packet's checksum =
field.
It seems to be for the virtio PMD running on the host.
Is something similar missing for the virtio PMD running in a guest?

https://github.com/DPDK/dpdk/commit/8f1750f42e2d2dbf49af59eb058e8412f0e3a=
fa4

