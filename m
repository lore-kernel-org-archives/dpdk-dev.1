Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B917C5CFEB
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Aug 2026 14:30:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7415B42D76;
	Thu, 13 Aug 2026 16:30:27 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 618AB40298
 for <dev@dpdk.org>; Thu, 13 Aug 2026 16:30:26 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 40F35206E1;
 Thu, 13 Aug 2026 16:30:26 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: [RFC PATCH v2] mempool: optimizations
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 16:30:24 +0200
X-MimeOLE: Produced By Microsoft Exchange V6.5
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F659E1@smartserver.smartshare.dk>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC PATCH v2] mempool: optimizations
Thread-Index: Ad0rGs6PbZF0D2AOTsSelZu3GcQXuAABOOjQAAPl6MA=
References: <20260812090723.1771628-1-mb@smartsharesystems.com>
 <20260812120626.1772120-1-mb@smartsharesystems.com>
 <an2w6xvcssfVEjTB@bricha3-mobl1.ger.corp.intel.com> 
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Bruce Richardson" <bruce.richardson@intel.com>
Cc: <dev@dpdk.org>,
	"Andrew Rybchenko" <andrew.rybchenko@oktetlabs.ru>
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
> Sent: Thursday, 13 August 2026 14.57
>=20
> > > +* mempool: The obsolete ``flushthresh`` field was removed from =
the
> > > ``rte_mempool_cache`` structure.  + * Removed deprecated symbols:
> > >
> > I'm not convinced about removing this field at this point. Based on
> > previous discussions around run-to-completion vs pipeline apps, and
> the
> > reported performance degradations due to recent cache changes, I
> could
> > see a scenario where it's useful to track a separate flushthreshold
> or
> > cache-keep threshold for a mempool.
>=20
> Removing the flushthresh field is part of the cleanup patch [1].
> I merged that patch into this one because I'm having problems with
> Depends-on.

The separate patch with the new optimizations only [2] that was merged =
into this patch (due to Depends-on problems) was marked as Superseded in =
Patchwork. I changed it back to New, so it is present for stand-alone =
review.

[1]: =
https://patchwork.dpdk.org/project/dpdk/patch/20260806154506.1532375-1-mb=
@smartsharesystems.com/
[2]: =
https://patchwork.dpdk.org/project/dpdk/patch/20260812090723.1771628-1-mb=
@smartsharesystems.com/

