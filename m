Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C85C282DE
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Mar 2025 10:07:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E229840EAB;
	Thu, 13 Mar 2025 11:07:51 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 5E07E40E49
 for <dev@dpdk.org>; Thu, 13 Mar 2025 11:07:50 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 4202520FF3;
 Thu, 13 Mar 2025 11:07:49 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v3 1/3] eal: add function rte_size_to_str
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Thu, 13 Mar 2025 11:07:47 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FAFC@smartserver.smartshare.dk>
In-Reply-To: <Z9Kg3C-L22fTKebl@bricha3-mobl1.ger.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v3 1/3] eal: add function rte_size_to_str
Thread-Index: AduT97LNavlM4kQ4Rry/AE2gb70UwgABeWpQ
References: <1741291408-26509-1-git-send-email-andremue@linux.microsoft.com>
 <1741807714-26748-1-git-send-email-andremue@linux.microsoft.com>
 <1741807714-26748-2-git-send-email-andremue@linux.microsoft.com>
 <Z9Kg3C-L22fTKebl@bricha3-mobl1.ger.corp.intel.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Bruce Richardson" <bruce.richardson@intel.com>,
 "Andre Muezerie" <andremue@linux.microsoft.com>
Cc: <dev@dpdk.org>, <sameh.gobriel@intel.com>, <vladimir.medvedkin@intel.com>,
 <yipeng1.wang@intel.com>
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

> > +{
> > +	const char *prefix =3D "kMGTPE";
>=20
> Why is "k" in lower case compared to the others all in upper-case?

That's what the standardization bodies decided. Let's stick with that!


> > + * Sample outputs with "use_iec" disabled and enabled:
> > + * 0 : "0 ", "0 "
> > + * 700 : "700 ", "700 "
> > + * 1000 : "1.00 k", "1000 "
> > + * 1024 : "1.02 k", "1.00 ki"
> > + * 21474836480 : "21.5 G", "20.0 Gi"
> > + * 109951162777600 : "110 T", "100 Ti"
> > + *
>=20
> I would omit the space before the suffixes in the output. As well as
> looking better to me, it also solves the issue of the non-suffixed
> numbers
> having a trailing space.

The space could be optional, like the "use_iec" parameter.
I would certainly expect the space when appending a unit, e.g. "bit/s":
"700 bit/s" or "1.00 kbit/s".

Or when the appended unit is seconds, e.g. for latency/jitter:
"12.3 ms" or "123 us".

With raw numbers (i.e. without a unit appended), it's probably a matter =
of personal preference, so I'm not going to insist here.
I still prefer it, but only when a postfix is present.

In the SmartShare GUI, we output with the space, and accept input both =
with and without it.

