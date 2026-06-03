Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 470EACD6E55
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Jun 2026 15:14:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6AE06402CC;
	Wed,  3 Jun 2026 17:14:12 +0200 (CEST)
Received: from fout-b3-smtp.messagingengine.com
 (fout-b3-smtp.messagingengine.com [202.12.124.146])
 by mails.dpdk.org (Postfix) with ESMTP id 37112402BC
 for <dev@dpdk.org>; Wed,  3 Jun 2026 17:14:11 +0200 (CEST)
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
 by mailfout.stl.internal (Postfix) with ESMTP id A416F1D00017;
 Wed,  3 Jun 2026 11:14:09 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-07.internal (MEProxy); Wed, 03 Jun 2026 11:14:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1780499649;
 x=1780586049; bh=tqQtOebD4mokR6mVERWxQ5rfjKiec3IVz5Cxbd6rHAE=; b=
 XKqLeEwYvu+juWnD183e+diHx56K37h4mPDs5wmeORk+9vN5U3HLoQko0co4EZOD
 n4hl7rFTRGD7TzQOxv1+q+p1wrIbPPOMz+uvCcWNoSm5eRTEeQEbK+ectheuQFzt
 uFC788RkZN/Nx4VippVxqjol5dlEFPTJZTuZN9FEp9JM5j3Se/PeYkCpTFEM4MWE
 PTIi4QnWkJpHuADIJWcu8kcODnbxpfH6OxKrIhsSK9NTRJ8TyyXPmt3pp3/nO0JX
 xqjloflJB8O/uxJAxlUdCoUV+JHWWXKkGeKarKD75Mg6FDV7PoRakukKPijQP9ei
 iAxStMEjSUR09VxV3/0AgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780499649; x=
 1780586049; bh=tqQtOebD4mokR6mVERWxQ5rfjKiec3IVz5Cxbd6rHAE=; b=Z
 yrWQ0nlC3W3LeNCG1dz1u4EwRCF+rowBb5bJaxMSMxvugbFrzH2Q5hmvF5Us2bqL
 uDyOib8E2VBxu4nzluGwfgflY9/xsHsGCdesVtBEJ+Z3/DCRahU3uvbtetVGcOp2
 fKxLvGj47Ezb3cheB9mZyCgFVXRD3i5hotrmnQ1lN4ElFT9IouniZ95O5VhiJmyI
 D9oEWRY/oRzsWM6D9yHF8/McNHzymMA8Ob5FqHwEKraXTP5ZTt+CICzIsZrvqOn3
 Pu3kJ4pGUF1mw9W6NCghLghgx2eo5Ug8P4LxXe99lA59QaoYA0w07BhnkWkz9V8T
 3luKUre+uhNPfcwk+M+OQ==
X-ME-Sender: <xms:v0Qgasuw07fhVxh_a7t7XEkoMD_DUzjNILwzu9ZqiiLtP_g_Wuq1OA>
 <xme:v0QgapkproXxgORXJ-9cyIFTXQOs9r5_ocgEQaDSUqWjyuZJnOR3GxFTG_Siq6WQW
 BHY0VtC5CdDBTgCuEOpPiM47I3mP7DLTsstaJHOmKrnT7XwmOB4>
X-ME-Received: <xmr:v0Qgavs1ZtlHe_zvwLjR8CXN30iuY3YzMuu5DkiWPuaxhJCNmJu3Y-x5rzJTHJ5mptkY4BsLmH8WitlAWeS69HMNfw>
X-ME-Proxy-Cause: dmFkZTFskg9keJBpmIZLyaSGant4zO9BPmVBp83eoTmbXF+yPthK22kHhchnI4cDG9orq2
 DYwOzLIbdEAIemh/8bSArDKBtvKQ3XvhuTEUNLV5RLOVP+X2mVQ8kl5Dwj7WvMT2SKBOJ/
 +AIkvvzWFPUWKqWzfsI1Q/7iO1yuqC1ZTxWgzJUFsJBwt9yQCU0mu5CHJxOq76eDuxcTdn
 swADbZITp5rHVYO4JpptTZHLNhnD9GRTt92w3g+POzGQa0jaQZbyvTCZr4JU2ot9XI24bC
 /Nj82OGpuLNcqTf//4Eagd2ToARFQKjcbtXEIYMc135DYHIfgntZRy8F9nMWNm9g9Rs9pi
 flglemfgXGqb/Ghoi0ZWjBFjq7IGuk+bpjP9q2O9AJcXUPjKJgMfZ78iPK7nKBNa7AMJZ6
 ibBCyLso5VINbI4s4JzelEJ/tavkPu+qr5gs7xRSRsedWF9VYUiMtXiPFP3qdLG7w3K7pF
 WBSJgKocRThSxqJ/UYhCOhbkSG0/UEKTMdpYuj8oEPh54JX5YpO7h1vlag5Ln0xN/osywr
 l/DjxuUb31ahLE7AhsxsGveUup/ZQzhZ1OThJoXnsx0GIV7Fp64Pm2GdpI7Gp6j9e07Oje
 ZII2AzrQCmBfELbDyZkz3IMj/coinpZ5hjh+2HQUmGq7nH09WiXVAMKNtOXQ
X-ME-Proxy: <xmx:v0Qganc-lzXUbOitKvXqSqWiUhLaTZLPLoDrObE0ZY_FriosHA-54w>
 <xmx:v0QganyQIuk3Q14t44A0NFdLHiGYm_BWJYo02-IxfXaaaNHtPP_NlA>
 <xmx:v0QgatH69uT4mBZycTNVOzwD-RPS_xmdr6bcjjXIgxmMWPIEEUAKqQ>
 <xmx:v0QgarzGbYbiUHUzDrEXduZgD2t9iVqHeWagfBc9C5OQtlzZLzx4CA>
 <xmx:wUQgarSpdLz4-AANTPqwPcwfvG_QQm94M6yku6dP4s15ctF81JoMn76T>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jun 2026 11:14:06 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: Re: [PATCH v2] mempool: introduce statistics reset function
Date: Wed, 03 Jun 2026 17:14:05 +0200
Message-ID: <Ugu5kfjzRK-EIGg0KQI9qA@monjalon.net>
In-Reply-To: <b2fa41c0-aed1-420f-ad89-775fe0024dce@oktetlabs.ru>
References: <20260223102054.336350-1-mb@smartsharesystems.com>
 <20260224092802.359592-1-mb@smartsharesystems.com>
 <b2fa41c0-aed1-420f-ad89-775fe0024dce@oktetlabs.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

24/02/2026 10:57, Andrew Rybchenko:
> On 2/24/26 12:28 PM, Morten Br=C3=B8rup wrote:
> > Populating a mempool with objects is accounted for in the statistics.
> > When analyzing mempool cache statistics, this may distort the data.
> > In order to simplify mempool cache statistics analysis, a mempool
> > statistics reset function was added.
> >=20
> > Furthermore, details about average burst sizes and mempool cache miss
> > rates were added to the statistics shown when dumping a mempool.
> >=20
> > Signed-off-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>
>=20
> Acked-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>

Applied with version changed to 26.07, thanks.



