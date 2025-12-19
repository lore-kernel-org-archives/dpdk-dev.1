Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84408D78776
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Dec 2025 14:02:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 99DD14026A;
	Fri, 19 Dec 2025 15:02:01 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id F2FC140150
 for <dev@dpdk.org>; Fri, 19 Dec 2025 15:02:00 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 319E922B35;
 Fri, 19 Dec 2025 15:01:59 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v2 2/2] doc: add device hotplug documentation
Date: Fri, 19 Dec 2025 15:01:54 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F655FB@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <e3bb33543d6a405874c89efeed15f01cefea3f83.1766150746.git.anatoly.burakov@intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v2 2/2] doc: add device hotplug documentation
Thread-Index: Adxw6wtQwp8qTFNUTB6VSaEIsxXyNwABHJUg
References: <e3241bd4c2224616c60b7f4b0145d37ebf612344.1766150746.git.anatoly.burakov@intel.com>
 <e3bb33543d6a405874c89efeed15f01cefea3f83.1766150746.git.anatoly.burakov@intel.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Anatoly Burakov" <anatoly.burakov@intel.com>,
	<dev@dpdk.org>
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

> +Device Hotplug
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Introduction
> +------------
> +
> +Device hotplug refers to the ability to attach and detach devices at
> runtime, after the initial EAL initialization has completed.
> +This feature allows applications to dynamically add or remove =
physical
> or virtual devices while the DPDK application is running.
> +
> +.. note::
> +   Device hotplug does not support multiprocess operation nor kernel
> device event notifications on platforms other than Linux.

Does this mean:
Device hotplug does not support "multiprocess operation" nor "kernel =
device event notifications on platforms other than Linux".
Or:
Device hotplug does not support "multiprocess operation nor kernel =
device event notifications" on platforms other than Linux.

Please make this note more clear. My English skills are not good enough =
to understand.

