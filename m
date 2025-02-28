Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A51CC282D0
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Feb 2025 16:59:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2D86840E2E;
	Fri, 28 Feb 2025 17:59:33 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 5C49840280
 for <dev@dpdk.org>; Fri, 28 Feb 2025 17:59:31 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 2CB12207C0;
 Fri, 28 Feb 2025 17:59:30 +0100 (CET)
Content-class: urn:content-classes:message
Subject: RE: [PATCH] mempool: micro optimizations
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Feb 2025 17:59:29 +0100
X-MimeOLE: Produced By Microsoft Exchange V6.5
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FAA8@smartserver.smartshare.dk>
In-Reply-To: <Z8Atll7rmVM1p4Ee@bricha3-mobl1.ger.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] mempool: micro optimizations
Thread-Index: AduI+GhwDeJrL14XR8qM3ksA8bTC7ABCWf6w
References: <20250226155923.128859-1-mb@smartsharesystems.com>
 <Z79G8hI3Yc6kcT2O@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FA86@smartserver.smartshare.dk>
 <Z8Atll7rmVM1p4Ee@bricha3-mobl1.ger.corp.intel.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Bruce Richardson" <bruce.richardson@intel.com>,
 "Andrew Rybchenko" <andrew.rybchenko@oktetlabs.ru>
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

> > > Is there any measurable performance change with these
> modifications?
> >
> > It varies.
> > Here are some of the good ones, tested on a VM under VMware:
> >
> > mempool_autotest cache=3D512 cores=3D1
> > n_get_bulk=3D64 n_put_bulk=3D64 n_keep=3D128 constant_n=3D0
> > rate_persec=3D1309408130 -> 1417067889 : +8.2 %
> >
> > mempool_autotest cache=3D512 cores=3D1
> > n_get_bulk=3D64 n_put_bulk=3D64 n_keep=3D128 constant_n=3D1
> > rate_persec=3D1479812844 -> 1573307159 : +6.3 %
> >
> > mempool_autotest cache=3D512 cores=3D1
> > n_max_bulk=3D32 n_keep=3D128 constant_n=3D0
> > rate_persec=3D825183959 -> 868013386 : +5.2 %
> >
> > The last result is from a new type of test where the size of every
> get/put varies between 1 and n_max_bulk, so the CPU's dynamic branch
> predictor cannot predict the request size.
> > I'll probably provide a separate patch for test_mempool_perf.c with
> this new test type, when I have finished it.

Here's the above mentioned patch for the mempool perf test:
https://patchwork.dpdk.org/project/dpdk/patch/20250228164858.274204-1-mb@=
smartsharesystems.com/

