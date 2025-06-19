Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA41C7115B
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Jun 2025 12:57:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0FF4F42E76;
	Thu, 19 Jun 2025 14:57:28 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 93C934025E
 for <dev@dpdk.org>; Thu, 19 Jun 2025 14:57:26 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 698AB2196E;
 Thu, 19 Jun 2025 14:57:25 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [RFC PATCH 0/5] Introduce mempool object new debug capabilities
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Thu, 19 Jun 2025 14:57:22 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FD14@smartserver.smartshare.dk>
In-Reply-To: <20250616083009.4a2d69f2@hermes.local>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC PATCH 0/5] Introduce mempool object new debug capabilities
Thread-Index: Adve05EaY7ODqUqyRmKdiFRvvHhdsgCRS0zA
References: <20250616072910.113042-1-shperetz@nvidia.com>
 <20250616083009.4a2d69f2@hermes.local>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Stephen Hemminger" <stephen@networkplumber.org>,
 "Shani Peretz" <shperetz@nvidia.com>
Cc: <dev@dpdk.org>
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

> From: Stephen Hemminger [mailto:stephen@networkplumber.org]
> Sent: Monday, 16 June 2025 17.30
>=20
> On Mon, 16 Jun 2025 10:29:05 +0300
> Shani Peretz <shperetz@nvidia.com> wrote:
>=20
> > This feature is designed to monitor the lifecycle of mempool objects
> > as they move between the application and the PMD.
> >
> > It will allow us to track the operations and transitions of each =
mempool
> > object throughout the system, helping in debugging and understanding =
objects
> flow.
> >
> > The implementation include several key components:
> > 1. Added a bitmap to mempool's header (rte_mempool_objhdr)
> >    that represent the operations history.
> > 2. Added functions that allow marking operations on an
> >    mempool objects.
> > 3. Dumps the history to a file or the console
> >    (rte_mempool_objects_dump).
> > 4. Added python script that can parse, analyze the data and
> >    present it in an human readable format.
> > 5. Added compilation flag to enable the feature.
> >
> > Shani Peretz (5):
> >   mempool: record mempool objects operations history
> >   drivers: add mempool history compilation flag
> >   net/mlx5: mark an operation in mempool object's history
> >   app/testpmd: add testpmd command to dump mempool history
> >   usertool: add a script to parse mempool history dump
> >
>=20
> Could this not already be done with tracing infrastructure?

I agree with Stephen on this.

And, if you plan to use this for performance measurements, you can use =
the coming PMU trace to trace the objects' movements between CPU caches =
and RAM, so you can discriminate between hot and cold objects.

