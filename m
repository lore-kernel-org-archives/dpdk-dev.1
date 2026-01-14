Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40DAED37E4F
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 15:31:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 23D404066E;
	Wed, 14 Jan 2026 16:31:39 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 7B7D5400D6;
 Wed, 14 Jan 2026 16:31:37 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id D06A0229AD;
 Wed, 14 Jan 2026 16:31:36 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: mbuf fast-free requirements analysis
Date: Wed, 14 Jan 2026 16:31:31 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F6565B@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <aT_1J0If92bxkLG0@bricha3-mobl1.ger.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: mbuf fast-free requirements analysis
Thread-Index: AdxtuIjdXq55X0PnStKTODRT65YwWwXrSXYg
References: <98CBD80474FA8B44BF855DF32C47DC35F655E0@smartserver.smartshare.dk>
 <aT_1J0If92bxkLG0@bricha3-mobl1.ger.corp.intel.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Bruce Richardson" <bruce.richardson@intel.com>,
 "Konstantin Ananyev" <konstantin.ananyev@huawei.com>
Cc: <techboard@dpdk.org>,
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

> > If I'm not mistaken, the mbuf library is not a barrier for fast-
> freeing
> > segmented packet mbufs, and thus fast-free of jumbo frames is
> possible.
> >
> > We need a driver developer to confirm that my suggested approach -
> > resetting the mbuf fields, incl. 'm->nb_segs' and 'm->next', when
> > preparing the Tx descriptor - is viable.
> >
> Excellent analysis, Morten. If I get a chance some time this release
> cycle,
> I will try implementing this change in our drivers, see if any
> difference
> is made.

Bruce,

Have you had a chance to look into the driver change requirements?
If not, could you please try scratching the surface, to build a gut =
feeling.

I wonder if the vector implementations have strong requirements that =
packets are not segmented...

The i40 driver only sets "tx_simple_allowed" and "tx_vec_allowed" flags =
when MBUF_FAST_FREE is set:
https://elixir.bootlin.com/dpdk/v25.11/source/drivers/net/intel/i40e/i40e=
_rxtx.c#L3502

And only when these two flags are set, it uses a vector Tx function:
https://elixir.bootlin.com/dpdk/v25.11/source/drivers/net/intel/i40e/i40e=
_rxtx.c#L3550
And a special Tx Prep function:
https://elixir.bootlin.com/dpdk/v25.11/source/drivers/net/intel/i40e/i40e=
_rxtx.c#L3584
Which fails if nb_segs !=3D 1:
https://elixir.bootlin.com/dpdk/v25.11/source/drivers/net/intel/i40e/i40e=
_rxtx.c#L1675

So currently it does.
But does it need to?... That is the question.
Paraphrasing:
Can the Tx function only be vectorized when the code path doesn't have =
branches depending on the number of segments?
If so, then this may be the main reason for not supporting segmented =
packets with FAST_FREE.

In that case, we cannot remove the single-segment requirement from =
FAST_FREE without sacrificing the performance boost from vectorizing.

But then we can proceed pursuing alternative optimizations, as suggested =
by Konstantin.

Here's another idea:
The Tx function could pre-scan each Tx burst for multi-segment packets, =
to decide if the burst should be processed by the vector code path or a =
fallback code path (which can also handle multi-segment packets).


-Morten

