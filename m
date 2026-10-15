Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A61CC6B38
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 18:38:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3BF81402E4;
	Thu, 15 Oct 2026 20:38:54 +0200 (CEST)
Received: from fhigh-b6-smtp.messagingengine.com
 (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
 by mails.dpdk.org (Postfix) with ESMTP id 88506400EF
 for <dev@dpdk.org>; Thu, 15 Oct 2026 20:38:53 +0200 (CEST)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfhigh.stl.internal (Postfix) with ESMTP id E64407A0101
 for <dev@dpdk.org>; Thu, 15 Oct 2026 14:38:52 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Thu, 15 Oct 2026 14:38:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1792089532;
 x=1792175932; bh=JM/DpWqnJWxxanbduN5iUMLrI2H7AB2ZxRsfEt34C+M=; b=
 XWSan58nWwsI7zitHb7LAjXnIM9Db+K7O7xvK8f0qECwYLDxT6YP6u2KUqYb+qTQ
 j9Ry58QgWgrKM19Lc2sZp7M8H/1GzVzyQ7dmXXkIWTBLsNp7WZLQH2BTo8GNqKKF
 CR79ApDtLzvYcT0OYGmC94XeOyohlbN3DmQUFwU22H+Mj3J1SIN8L4CH3H3HkRRP
 3Q2fz8I0eBXcwg013VNP8s81mTZAHb3uKR5HlAqWnp4D6QP3zp7tMkQVSHVP2BlT
 GYBa7UvQk8dD/Ce/uyx1mehZIJ6H4AVgqG/mMhHi5b4pT/JdjuYtpl4iGx7eq9vN
 MZ4gW6AQjRZCt4LQw5zJyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792089532; x=
 1792175932; bh=JM/DpWqnJWxxanbduN5iUMLrI2H7AB2ZxRsfEt34C+M=; b=m
 EBafY5AKQEgYJk7uwD3VmCJUk5WcoSLxv3YCjoN/Hn3mOSY60uDjewxsJAG/+EBs
 VTv8rqWVBBrk1BbliIyAK6hB9e+ZHekYYpNkhm8slDhQslhuTMnz5y38KbGHlq3N
 WkEOc26CdZT9/6FUdx2kaNs8ohWkWzTZe5brMkI1CfabUvDjYomKnRMB4iE67666
 g6JgkXWH/Tm0K49uZPG7BptRh4TYFzwdbkxYY+WQIL/SWEeh57HDGzbLOQGzIJgz
 0aR3JEARGkI7IUmUeDTi9pD+ImhiyA4lWtO3zb441M6h/ZdQ3i8T2l1ba0kCB5ZS
 Q591Y8mrmZL5if3Xgu6KQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792089532; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm2:rsa-sha256:LIV+tHdIYoY4SAwyLwjXm2rST0mUv+cF8/Pc7s6EV1JTEbA
 pcO/mw0KWlaRQjeBnP+PdtEPBbMrAl/sa2FoMnz/qXK2rPxV8TqeI3natEpaNdN8
 I7PhC/i4sel5Akne94dGu5suKWX5/spqZgG5Zsg6XyRuPHGIZ2J0wNg+g68mjhlW
 L9kr6huDNoz7p+10jf59nZID6F7404mOXs7kN3ZfZLrTFZl38/odwizZnZvsaiI0
 eNowYh0qJB9SsqWHgInUI6BNxlPZOnSCmkVef3zBHJ3AxsrYW5SerepLehf8xuqq
 DwzmmqtA4BC+tbwzLbJithOsJD4dYeqb56nFXQA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:oplP7fgaJtFNbSqOCMERrEHyffPZpSZ6jEluwOVaAIk=:Sa2KJiLayDjehYQKCwLnsDk5BPKC7IBkpsTi6CV+Y38=;
X-ME-Sender: <xms:ux3RamdArmqe7pCmVJNcTZAVTzkx8WmV9lST77UCOE0ydGSI4SJ6_g>
 <xme:ux3RanO2MA5Oi8IVtsJtI6bBPVf9dc3V7g2S4FKh2CcJ8WRmTn5vNjKjejDQHyda1
 OUFMjUgnvYE7CuifS9LvQ4DPulkowhufutVbHslW9dX1ub82BoAw6g>
X-ME-Received: <xmr:ux3RasgOlyhjZyFRndpKCQKrNMoh8bpmOaQY1WAxgibEexmzTCvF_rWQliNDtSlxHJRVDjRaHWhi7Y6ZOVnUYFI>
X-ME-Proxy-Cause: dmFkZTFwFm/zo8M0k1UEedPb5MaoIV8wKrt9NcrKXXlHP1J5Z8t4n1ufXXRBI/etiARK9v
 dUINrILN60r3XVN3o1rTkAj4xs5o5IXsqx9etoeINDgNu1RrGhCytKHt8a51bYD/HnqxYR
 42iwbyLLILEnVRRMvStxYgHOFnSrvEyrF9btMXUlDrrTE1+hI9XP/yfvhkL0DN4zWPf94o
 jxgqyVCF9qNmt58vbAmw+wpBFrWQU69zlyR8eRMTtwQJ26okgoVM/7PntsVlgkjUeJNnDf
 lr2GN77sFfKZoGWnY848h4Ch90069bDVTli443YgidgGM50O4Zyjmdg3LMPv0pdJV6izr5
 0xTQVdTbxv9oG0LLUgIr9cW11E+lIVSsvdT+GgISG3QJs0VEvzehsDgNcidDCiBEmzV3Ys
 3tXcbUTU0+czx35GCEM+PF2bqhVhn0SkQyS7/0uIidMNNIYotQfM6qsNcTDUT6xZ0MxAOB
 fCRM6gCqUd4u+19dj+GXCfgt8glgWl6urT0VBtWNlyM2qOamjZhJ3Y3IYEFJeUg6XMqunE
 qNggPI8/zd6UvNRN7bOelc4tf4S7bQKfcc1AD7MMWM5lZ23vx7rbrwspAGdOsh++rGRRU3
 qim77TcRXBv3UTrXdqopsedZgqcouKolXptEhz2CrMs7s+pIvZYtc142MnWw
X-ME-Proxy: <xmx:ux3Rai0JGeneieNglzU3Or1RhDbYJFmLyaYlC9JE-ylQoy3dkut_BA>
 <xmx:ux3RauiLpOaeSQSLvdvc_fp6QFQGuJZ5ED6OvBiYg4g8y7bwJ2k--A>
 <xmx:ux3RaqdPOILM1g5NnguEEfTh92c9yuWeDTaT-i3fX3PSfqnxfhQ_Zg>
 <xmx:ux3RapkHadH3c--_D-0WUVAf3keH4FDgvMm6svOQPo3tELHBVYqgXw>
 <xmx:vB3RajKHS170eAyBJ6bCdfq5Zqdlj-QEb_BTCDvFq6IcoAkkKPzklPhe>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Oct 2026 14:38:50 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Sun Yuechi <sunyuechi@iscas.ac.cn>
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>, dev@dpdk.org
Subject: Re: [PATCH 0/2] lpm: use scalar lookupx4 on RISC-V
Date: Thu, 15 Oct 2026 20:38:47 +0200
Message-ID: <VZaQBRv0QC-gmh3m6UJqkw@monjalon.net>
In-Reply-To: <cover.1791181595.git.sunyuechi@iscas.ac.cn>
References: <cover.1791181595.git.sunyuechi@iscas.ac.cn>
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

05/10/2026 08:30, Sun Yuechi:
> The RVV rte_lpm_lookupx4() beats the scalar version only on in-order
> cores, and only because it reads the four tbl24 entries up front.
> Patch 1 makes the scalar version do the same, patch 2 removes the RVV
> version.
> 
> lpm_perf_autotest, LookupX4, units differ per machine:
> 
>              SpacemiT X60       Sophgo SG2044       SpacemiT X100
>              (in-order)         (out-of-order)      (out-of-order)
>              rv64gc  rv64gcv    rv64gc  rva23u64    rv64gc  rva23u64
>   main       5.5     4.4 (RVV)  2.7     3.2 (RVV)   35.2    54.3 (RVV)
>   patched    2.5     2.7-3.2    2.7     2.9         34.6    41.3
> 
> Sun Yuechi (2):
>   lpm: load tbl24 entries up front in scalar lookupx4
>   lpm: use scalar lookupx4 on RISC-V

Applied, thanks.


