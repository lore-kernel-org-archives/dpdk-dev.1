Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E8DCA5FA5
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 13:30:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8012F42791;
	Tue, 29 Sep 2026 15:30:29 +0200 (CEST)
Received: from fout-a5-smtp.messagingengine.com
 (fout-a5-smtp.messagingengine.com [103.168.172.148])
 by mails.dpdk.org (Postfix) with ESMTP id 9351340E36;
 Tue, 29 Sep 2026 15:30:28 +0200 (CEST)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.phl.internal (Postfix) with ESMTP id E819AEC074B;
 Tue, 29 Sep 2026 09:30:27 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Tue, 29 Sep 2026 09:30:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1790688627;
 x=1790775027; bh=Z0PHiV7ppbm9PA5J8ZzYrmYuixzNnarAeXERGc1i1gA=; b=
 Cbz8sjX5IWHMvS4fi3MnoX6o5jJ1iNifc54Bveg0S+z3t7hlZeI2TmkatWAq9LnF
 MNSMdxA1QwH/BGDHJLtMTGVo5B3IOdbw72/bI0mMXiQ15mV6pu5zd1N2Bc9ZCMX9
 BdIj87dzyPLjl6FHaaCOLjCa0UP+nTzpiMZ/ji3m2NmGjk+l4SH5QBpVyzWJNI/8
 uRBdcgT/7IeMFckr/sCd8MOvSZ0iwqDKXmzWW9lyh0+uXU21MeAc6bfBtwnLPTaA
 oOUrzXUfqBpzygXiXcwVs3X/i7oRN95mJBSwC+vj2ysxmc8HLtpo8MlkPQ5dWgnM
 RinO+KCU8ZiqOSgqR/jVAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790688627; x=
 1790775027; bh=Z0PHiV7ppbm9PA5J8ZzYrmYuixzNnarAeXERGc1i1gA=; b=K
 uMOoVah4QpiKmfbyIJYaU6HQbrTU1ehya6/2XBQ1Zi1hBIbeMsHleDd8oT+QvkYz
 w+GOUg6yV5v4iedSWxiYxSbrdaoaA4xHi+dcu4Lf/Y8jjjUSswqySlbiq2yt3plW
 pnmw4OjyYguf0SPqRnC5qAnO5E7dhipGxnt3pImtN32NZNaGwGcFQn0QP63tVVGW
 y9vwwn+XTt7Ge+RPVEYEZe306Wf1eFyDWJne/J36pUH287hWUebFqyQbT9fTE9pL
 CrJUNmFuCGqc2389aFH6aonCfqzj7TpL8G8TUV7/o9eRojP8q+9gmk/t6i1LBPGY
 9OFbAavHBPFQU93YzAqSQ==
X-ME-Sender: <xms:c727ajQ8_pHo_lDzmb_doxKYFDw4htQLI0N67xs_R4bn6NRRBvgThA>
 <xme:c727ak7b1zUf0YiCY-sCQrvycdxyQ5mvxWZvxm31XuINiUYpy4v3nWSUfqd-PCHlV
 mFhghF4nl5BY_S17K98zv2Hh1N-W7AQIGPs0IKAZfSZx55lRr3zXKA>
X-ME-Received: <xmr:c727agx-qxmCOEVpiwSQ7X9OrOw1igSzxgQ24tVeK21Ri44Dk44BoOvdrvUVPsY1zt00lulMoKuTTR2rPd0TKz8>
X-ME-Proxy-Cause: dmFkZTFffsqnrGCloA70g82q8aSJBefsKAdvPM2vqOLZt1K70BLNr5LVfy/Fz9kmkD5Q5l
 DcIHdcNUJNNOEQx91Y9ME6FwpORWSVVRX3mMz4QDlpDlKMgNcQBxHIRRBrptqpN9IbSmwO
 z9ZyYUSxpAuTZ5TswqdT1X4l3tngqfpLujZoChPWgFlcHegdAxziUcJBWZSBqvl+xVcNzu
 Kosz3fqQJJMH5/Tc2//kUrVLDIc7pfUf4qq5u16xyCFQ85OahLq1P8zH6WtZUoHwzhEjEK
 1/bIVgUDb3+IRczeYdsh1Q0SErSGlq2mvJu+RMOoZ3tWjv5xLhVjtHtTS6VRTO3XTJ8jUY
 VHlSD0Tf+ERcq6S1MOPybR9MoFu/tTXXn2lXcKo4FAwzKhZKQs9rGZH+MonnU14YzBe9no
 xSOhAcu8o8MAjmCPwOlCYvvCRKuqtgw1g2omgaxJ6wRorjk53N8hEGEb1sPFp6AXfT//sg
 epYDeSfTu/7Kz5CBmTdanDfwLlXqDwXafYEU1Pw/ib9fnTuPe7FM+hBCBWIiPTicN280JW
 UtohbGf7J1cILMZDRLWhAoLwxKgNCeQ18D9PtBXMnYB/FrDZx5LW+O4zt62mS4cVP190fI
 lc0+xJotQcTknNNvwSPDQoZ1lE7d/SwSQHEm/4m0CBt116qEFPd5GY1R76Uw
X-ME-Proxy: <xmx:c727arQzgv8tpdPjHKGmOyxyv8rIlxGyqY5wTzsCsV1zWbqwHdUtxg>
 <xmx:c727anXJvfTE3z1dsRaGMUZ19Zs-81vzaeJUUY5Y_oZ_wk9o9bpogg>
 <xmx:c727atbyyb7a7_E1WRkdaBmd5heyNAhTrzFFL0YdBnHLOyohpcOTbA>
 <xmx:c727at3escrCBYucgDWZ49HTMp-Z2zchlXFg5jVjoWn-XEPdKtX7Qg>
 <xmx:c727ahTnf0KEDaF8U0a-mS4VB3Fp3sy1n_BdNk9FgOM9TJaxPswNC1Sa>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Sep 2026 09:30:26 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Zhang Tengfei <zhtfdev@gmail.com>
Cc: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>, dev@dpdk.org, 
 techboard@dpdk.org
Subject: Re: [PATCH] mailmap: update contributor name
Date: Tue, 29 Sep 2026 15:30:24 +0200
Message-ID: <nLiq8zk4SyuCC_MjhReN_g@monjalon.net>
In-Reply-To: <c846b990-8b40-488b-95f3-c151aa9c6b9e@gmail.com>
References: <20260927035949.36887-1-zhtfdev@gmail.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65A81@smartserver.smartshare.dk>
 <c846b990-8b40-488b-95f3-c151aa9c6b9e@gmail.com>
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

29/09/2026 01:12, Zhang Tengfei:
> On 9/28/26 22:33, Morten Br=C3=B8rup wrote:
> >> From: Thomas Monjalon [mailto:thomas@monjalon.net]
> >> Sent: Monday, 28 September 2026 16.22
> >>
> >> Hello,
> >>
> >> 27/09/2026 05:59, Zhang Tengfei:
> >>> Use "Zhang Tengfei" as the primary name. Both addresses belong to me
> >>
> >> In DPDK we try to always have the first name first.
> >=20
> > "first name" -> "given name"
> >=20
> >> I assume Zhang is your family name?
> >>
> >>
> >=20
> Hi Thomas,Morten,
>=20
> Yes, Zhang is my family name. In Chinese the family name comes first.
> To avoid ambiguity, I'd like to use "ZHANG Tengfei" (family name in
> capitals). Would that be OK? If so, I'll send a v2 of the mailmap patch.

It is a discussion we never had in the project.
It is being discussed in the Technical Board.
Please wait for a decision about how to proceed.
Sorry for the inconvenience


