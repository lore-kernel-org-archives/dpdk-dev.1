Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD452606A32F
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Nov 2026 01:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=monjalon.net header.i=@monjalon.net header.a=rsa-sha256 header.s=fm3 header.b=c4Askm7u;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=sCp7QP0L
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D72A9402DE;
	Thu, 19 Nov 2026 02:36:13 +0100 (CET)
Received: from fhigh-a7-smtp.messagingengine.com
 (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
 by mails.dpdk.org (Postfix) with ESMTPS id 27E91402DA
 for <dev@dpdk.org>; Thu, 19 Nov 2026 02:36:12 +0100 (CET)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 2C36514000D4
 for <dev@dpdk.org>; Wed, 18 Nov 2026 20:36:11 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Wed, 18 Nov 2026 20:36:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1795052171;
 x=1795138571; bh=cUfT/mSmjh6cxIWlSbrYwDHwqxeOoXTmVLRJ5/mt248=; b=
 c4Askm7ubOedms/o4Zxy97gt0m70JUzXvFh99kLREcXxO/VKAXVxYPevCZ05yRuX
 ZtQ0m6RsLiHxaTwQoz30dNc+S75ShFyWR0ygkqZkA3+yzfTjYIwSofrqPiTeUe0J
 fu8J0gxh7NEnkoOqIoaUJnJds8uJxrTMTpa1h/Qi8WLnvqM3w8m5fQv6tjCx/60p
 kjbuek3bCga/Mb8SeRcPTThEQJ4HIZEjweO0ocyjJSXeWf2NkdILqGbAqaPPEHxh
 AVZ57GhUd6D3kk8hwct+x9QzPczmgPC21DWMlH/IbezVVT9o3/X0qZMlgaWliVxv
 KjAYAuRUSwxQD+l+1VGVBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795052171; x=
 1795138571; bh=cUfT/mSmjh6cxIWlSbrYwDHwqxeOoXTmVLRJ5/mt248=; b=s
 Cp7QP0L+RTHOKHQWdJh4069QgawoJB1jRXSzL3VDytGS6do9BORSp62C11LhrUgn
 jpplPCvmR9OoOg92JjjVSzVTT/vQx7SIRGTpBjr1BOUPPE0zD2iMcFNEapLZi1AC
 7fITFwNggFLvK4k4uk3GiwlG4oclRJ7d9AJLPYxmxaeiV/7OM9R3xbbfnNs/pdPA
 58FTsHTE6ksP97erUJJ6gDgh6jazIcSHcKYLfPKebEziBF5MKDWuW/sfqZyfGGDR
 bfD9eamx/p8Ens3TTE5fVcvi5ajNiVWE6WYPDQkRkuf2OciXi4O3pOXfXlAKSzag
 rlEXxO8RDVXLCAPHdIoQg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795052171; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm3:rsa-sha256:UnOVIaHFUwZgUzP3I5t1qaaxYD2t+P05AVRHtN85ESEIXzL
 qfEAuWT7Ocpzyr33D/jXzcm0zRSXHsjrq3PjMnBgjG3FsQeqkQJDjDgT8jh/bTZz
 djHd95cq+kowA1UCB2+Y32Fp9ZvuRu5BysjM2IWK3RGVIqV9V2jjfRgkP9lw6Gz5
 JlbEWuq72/QighWbmSzfuIFw7wLhGq/dRsYUOM5LQmf4I3Qtg34cV0bzc7KCnmDY
 hTiuiGcXdcpZ5VbJXrTOS6yFhR1u3QmWBRCnzg9lQ1WSPlcfNkUshjZdVbxjHtHM
 RreHf0OTFELOSUiVeYYvPG30GYC6SXsjlJGHZeg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:Bam6cpl9SKbvw2ipmsQOjSYpoI5J5yYiTAS+15GQEGM=:5hhSyS3yF4VepHPsKhQlekGLPoIL7MzqJE7IPJjcYCA=;
X-ME-Sender: <xms:ilL-ahGy2hMb_5km9Jhrh4DkGPUkW9Yw37ZF1grLk631vDJRCTXwQA>
 <xme:ilL-aioEcJdv-ERBfz98Cb65EIEYUem9bbW7BcbnvhiSAwXh9ey8nrlm3pC7886s8
 QwGPej9wj7Lu0xJ99PooTOIKWOaBw6TkEF8jDBSOLZqMtVmLxvh55I>
X-ME-Received: <xmr:ilL-al6LJnDkMb5N_tun1T23G0skcFSDZMwJj0A3JueOYqXOehmQALLQIy2Hbqm82F-LCj8HB8moYueb8K_knoM>
X-ME-Proxy-Cause: dmFkZTGph15xSjqA1OYfIhlQpnW3bT+7g15kAJkfPfbCedxbxJUn8Ula5SPNHJVblpM2kG
 8B+C7JLl48NANhdBrzF/Xbll85IE1x35k3PBYVG/BqCJ7bIc08znC517JDnkNE8Ptc3C60
 xmExk1cUaqGmYI8cc4IEAtPKYXaYey6akahMsCKOZXG75M5DYqAtQ9/ryEriqDTF5K/77a
 YuetkX744mmOK/LY/6IpygEPuJYLMh5rb/xd1AwivsDtteorkV+LYYYgpA760xwsYqZL3H
 uBnCxluo403e6fVzkQ6h0Ke5OdEkDTLRMMNfQpPEg05LxvqH5i4KDdpW7LY2IlaH0vXTFF
 0ihcSb2Sfyko+gvcOHeruczwdSo/VyngdzFJO+sEgUC5tObr2+TE/QXibclKUtAy3+/Kjw
 iP7A5ez3ilec4Q79R+gmXmsskBmdPLDbEJ0BLN4r/BtH+KZdfn46abELK0VZ+5XGdrIQvQ
 xyhBY0d2AokR8Mga5aa+o93OdP9JTdAGU5CObBOnoAnrgiD+Kuh04PBDte9WD0dcfccwR+
 zYAQcrpr8+zoZUZW5s1XewPkWx8Rz4IBf7RfE/bGwDysOJppp8qQHT7YQIJiFSueZnj822
 jSRlHqR2kDjvopZDfzvsLdpKFGRC+5G04PWWAAoKsUmMR+jA0u+SEb7Ja7WA
X-ME-Proxy: <xmx:ilL-ao5q2zjJY6ua_j_bS3MDD7oegwz6APBYicHfoMJ7JoftM2S8Jw>
 <xmx:ilL-aqHoWOqLzXrZPgEUODoZngidQS87bmbSZzg98iVwmMthpQHitw>
 <xmx:ilL-apT7IeMts5HQHCrhIM4-w-WWcB0UNvcVrT9v9rwkZU3NWXneHA>
 <xmx:ilL-aruTtWujwMBqM_EOQ9DwND59fOADnMWMkRD-b71NenQC86s4Nw>
 <xmx:i1L-amM-e7Fm4SKomKU5mzHeT-rh0kjqRcGhQDceufdfKZ335P3hQWxn>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Nov 2026 20:36:10 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Kai Ji <kai.ji@intel.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH] app/wycheproof: avoid path check before opening vectors
Date: Thu, 19 Nov 2026 02:36:07 +0100
Message-ID: <Ad-bjAABQIuKcHhbeHhYgw@monjalon.net>
In-Reply-To: <20261117154949.4153145-1-kai.ji@intel.com>
References: <20261117154949.4153145-1-kai.ji@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

17/11/2026 16:49, Kai Ji:
> Checking the vector path with stat() before opening it leaves a
> check/use race if the path changes between the two operations.
> 
> Open the directory directly and fall back to file processing only
> when opendir() fails with ENOTDIR. Propagate other directory-open
> errors and remove the unused stat header.
> 
> Coverity issue: 360736
> 
> Signed-off-by: Kai Ji <kai.ji@intel.com>

Applied, thanks.



