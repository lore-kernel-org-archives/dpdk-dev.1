Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE8B3CC6B03
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 13:21:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0DD2340279;
	Tue, 13 Oct 2026 15:21:11 +0200 (CEST)
Received: from fout-a4-smtp.messagingengine.com
 (fout-a4-smtp.messagingengine.com [103.168.172.147])
 by mails.dpdk.org (Postfix) with ESMTP id B3E5F40272
 for <dev@dpdk.org>; Tue, 13 Oct 2026 15:21:09 +0200 (CEST)
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
 by mailfout.phl.internal (Postfix) with ESMTP id 09296EC0883
 for <dev@dpdk.org>; Tue, 13 Oct 2026 09:21:09 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-09.internal (MEProxy); Tue, 13 Oct 2026 09:21:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1791897668;
 x=1791984068; bh=Wx15BR1/JJ5ngCqusotSD58J/wv51DyRP78EyMFerr8=; b=
 oYgNd7uE8R7Edl+GexGWFysXcWE3S/pAfPM8SzUGIwnlfIG4K6te/BLi202lUf1Y
 U4l9+oA+BGm4DLQbqIKr5sofgKeuLwlzlJM3JOtOZ5R0Gd7u4EDJDQWDMw2OpTLx
 JimwpT9Cu4/q2Z6Yv1OqhS4uWdAvUBNXC0D77QRHwAzy43apsXVM0Fc22aUYQ63W
 4ou3yjyoFcLJTNkEJ1xXLDs93I6ZnKC/HMEIwMmFRhVyiCJFt+ShsNYJT3WyoPnw
 UT7puGSpMryFcjOnu5EplsA0Wr6VvRET32jMZJtwNO3AheOTS7mqkt1CVfn9p8Gj
 p7uLRUTrAAA0nNX5xUXQ8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791897668; x=
 1791984068; bh=Wx15BR1/JJ5ngCqusotSD58J/wv51DyRP78EyMFerr8=; b=t
 V43IDsetjcaK+w36hDloTN3WMOEVkjM0at+p/1IYybUj9dcdkrAI2wYXtFtNXO2g
 080wtytltM8vDGqi51t1VkjOtfRoYoiGDvm6LH8S9plXrglPfXnqBxI2mmijS8y4
 pm+x8H0ALY1GRzkbTPT5hMVr8zLeeJa+OjdZIv4n7Vu5BVJzDVbz4XMcl/L4IZO+
 yUpZf4r/4j/HD4CmNfAN2UlRtXoqEi8c66FcMi3bOkDd9GHIdrO15jKto9sMyRGG
 Y3wxZWbRxGyUsLtMyPQ11N2nNHGGy9AMF51S5wZAjXB1psJSJpn7v9UXdetrwGTi
 wgW4chRryI/Q1lQxVepsw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791897668; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm2:rsa-sha256:RM0Gnp76lZI39EEtPfB7HnpoSCDRuWbffwp3jyF7rlxoVnw
 U/ACWOvNzI3pJO+IPTLM9h/jucovgcwSt4bVsRs5UnDA8feeK+9+NXZ+qBjV0Zir
 xiHyLhYJyjWExv/+Gg3iP6Ui+Po6YAsmRECqOorKNQtt2hlBxOXRC36ottLI3wSE
 fzVlmNajHFRqxywUsJJ+FDLo28KgY+9sSK7Guyv6pdm3k2OR3kbUSlqWA+aBlrkH
 A+FBh5BDGiTRBco26G0xXIr57Gl8DHcpTzXZWhbfLOOrg8H2/JuH13vbHnPS9X2u
 honln28m5uhQUaLi/YGBRlHPt7vhS38iSy1oilg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:4xzu8HOAHOChWe39SXNuenUiEcxWCkRip/rqhZeAVe4=:wyN6YliWrw1Vi4AnPYlxwT6s6gLE960wC2kPrLtm80g=;
X-ME-Sender: <xms:RDDOapU0i8xNdC-cZrhMYSc6YNeAw1DgViEF6mA8uaMQNEAAw9ezEw>
 <xme:RDDOaiib29vj3weLPnzW2xHGHPvGqPZAtlid_JsFpYsP4vgMB56uw02gtIjT62hRe
 7Xf-MRinw3f0lG7OMREBNHcmwBKxClEQQDb9n6ByUny9atw8Jm17A>
X-ME-Received: <xmr:RDDOag9IAPkTtdFppgSiL8lqeJDBR_M3zWn_GjgcwwYqPxWhYXP4Du3FyL9wOAUj0foh96iEXOy1qD9pXKw0RVY>
X-ME-Proxy-Cause: dmFkZTGS0TEQHSW6xHa4jsp+66G+F3n9BwiE5yEquBYYpg+Ff84Bu2oS0+6/08BsCGOJkc
 IUY/PMyk2fqmY7z1Nra8otGqO7yt/F8SgvS0rLv+t0LjpgjeafpewoI8GB6uQIeoBP/ncl
 3s+FQgu9kuRR9iEC5nerRu5MRI/M93ikGASyIP4RLh+M+LBHUR2WyaMdoMU8iqhfdL82RB
 wqx5ta/i+/FmNkWw2ynTd+YQZRnR/vWJ3L6aHIEqKhMeArjJ3u7pkc/NYkrA6IXBYNjdrI
 Ew2PKE41sD5iOuKbprnJ11cmJiRsk6Y4Bt6+O4B/dB159bYPLADgwRZakPSL+gv5zIiEfs
 h1aMhCq71fcL9RSHa8a/B96WtvHtwkh2h7wMmV1fl6OKvkze9MPpqlTi83km148pl7ger/
 d39K82XEhSOUAKrAgBwUA+acmBp2stunxKiYLf9vAkIopPwEp81bNTzhM72WiOYkEBf10b
 YZENZWNL+X0fiIRzrR9+28CygvUvEaqxm0ZRpjYAGIaejn7erBU/JJyOOmZPQCFRM/tqq3
 zp1PuRjLiSpVQo7mJSGLaG4rqXUo6VwDaJXPnrkE7hRBJA7HiSEbcelxpNslGCSFdb6S3X
 O42Y5ipRacOR4VMmn5CZI7qQ0OAVm4NItIlUjTe09w+0sHXl0o1yhCm7L6Vg
X-ME-Proxy: <xmx:RDDOasZpIa1L8dMzr23ShYZ8uE2TeK_23sDww0vBr1MLDCrYjTS8yQ>
 <xmx:RDDOav1HjTvn2p-6z9rv9wChr2Vz_A4saWv0uAGJL9-LAldw6qA9og>
 <xmx:RDDOanZk_vCfdcyhPdgWcGwVi6nTvPV-0Af7WJEJ-VE0ZAO9pJ5l8w>
 <xmx:RDDOanKZ0IHXqEV-067WovYLtUBBFXpSQ9rc4i-y3n_JUf36zRaSgg>
 <xmx:RDDOamYPtFssVoNwJoB3T0J2wv0lR6HbLdPzZJOi7TaFF8QnWtg8jfnH>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Oct 2026 09:21:07 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Guillaume Gardet <Guillaume.Gardet@arm.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Sivaprasad Tummala <sivaprasad.tummala@amd.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 1/2] examples/vm_power_manager: fix includes
Date: Tue, 13 Oct 2026 15:21:06 +0200
Message-ID: <7fMhPIdeQaq8_F_20Lf1mw@monjalon.net>
In-Reply-To: <20260829024455.1557201-1-stephen@networkplumber.org>
References: <20260828215350.2861715-1-thomas.petazzoni@bootlin.com>
 <20260829024455.1557201-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
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

29/08/2026 04:43, Stephen Hemminger:
> Use include-what-you-use to get the correct set of includes
> for this command.
> 
> Reported-by: Guillaume Gardet <Guillaume.Gardet@arm.com>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Series applied with .mailmap and Fixes lines additions, thanks.



