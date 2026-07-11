Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF32C43458
	for <dpdk-dev@archiver.kernel.org>; Sat, 11 Jul 2026 14:15:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 320A140274;
	Sat, 11 Jul 2026 16:15:56 +0200 (CEST)
Received: from fhigh-a8-smtp.messagingengine.com
 (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
 by mails.dpdk.org (Postfix) with ESMTP id 186B94026F
 for <dev@dpdk.org>; Sat, 11 Jul 2026 16:15:54 +0200 (CEST)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 9F5CF140008B;
 Sat, 11 Jul 2026 10:15:53 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Sat, 11 Jul 2026 10:15:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1783779353;
 x=1783865753; bh=xctDyfp6jANgfQxWqK2qMP5E3NuZKE8tg0T4NIpOUBc=; b=
 AO+ZPXvei97hPiKjK76ZBIsvTW3Eabl3gpZdB/HJjbYAvTs4Rc3hJgqUr6ojERpO
 fh/zJ2I0rS786LpSKI2e+6A5LwWFPNpcNnXxghzvOjtJHEdc/EYVPzJKEuYoTYsm
 NB4gCzoDn7Rb9/bmWTR8T2yWjI3Lt9IfmvUx1KzOsWSGmIloqUQrNqQhp+ewSZZf
 Uu+lC02wQ/lAcZUGBJ3GOyxNLWwjqca4KA7JF/QTVdQD7rg6k7hBVAbG/MZcqKXc
 JyJYBM/oV8WW5OfmuuWUxQ+7OP+yk8RockuYSuGrvgwqGH2OXDS7ADYxmI9k3o2h
 V50oQhPdR0KIiupKUa/2Qg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783779353; x=
 1783865753; bh=xctDyfp6jANgfQxWqK2qMP5E3NuZKE8tg0T4NIpOUBc=; b=c
 FmJSCShR8vl4PsrcV0brnpsWSvrr2ciPyqbF7QZL9/hcyc1X4C+xX/Sg9CDeX32g
 xYxbvGWcX2jkPcIG9aIH+GXaCUN8V7KetgfutxFW52Ufc2prFT0gbFvrO1a1k8C2
 vC7ys/V/rhCeyB8CoAa+PZrbI6py++SlN0PGTJ7yOKXZtIFRAgODe+GVvokzsS9b
 PVizHONFIjLPNOHc2n9UhyDjLS1Rxi/41YIteFGp7E2haKDVae/PDCsBrhrcpQNN
 lM5Fjg7VP8CP6ZsdtC0/hnOB9r2GHLMVaa0963zsp1jPD/UVJIwHnlRWuuExhed/
 bQOIieaYEVEateqmkAJog==
X-ME-Sender: <xms:GVBSaq1xJNZ39Y-3VdCaf8vcn9g50How-jW4OR9mEMNZdeEZ_l7q6g>
 <xme:GVBSanI0bw_IE1JVBEsM_KtR6BfnOdnSanHKjR-TduEguWYJmrbyOwUT07VUZJAc1
 WIpAHFoAHSlF-0wy5yEqxCNO3jmDYSnsvhqeJHrkyjzyv13voA5Tw>
X-ME-Received: <xmr:GVBSaiwcaiSJjXmkJcPKep742cNBjvSffwjueTuTfuujzt39ikJPYSX53B33fmKHQtgK4gsyVRdz4o8y7A>
X-ME-Proxy-Cause: dmFkZTEnnjFQdqpoASbaG55sXPHv1wkaU5ksVUI4iSJTIQJoxGEqonx6RbLESlD0qXkSC4
 4y6cTqei+WQDMR9qd1+guO+V6amLmlZDWvKqF8v0/7dy38zQtcDluDRx76T21Z1JG+5tbg
 Km9bUqmom56ejFPl3wf5CCtnea23yedYjVoGnb/XCUw4C7vcFzc9F1a6R4APiuELFVwc6e
 5UibgBpjaTJdX8amuXktkoDa+582KeAE0mm9/UTNqkjd5GxE3fXwgP3ELyzWCvkiMrSC70
 8EZePerbiX2bY09WWwRjLNCVAQ57nmbJnxsIuNgKnFAG2SRK9dnUFWUD6lHpYOfRelLBNW
 saz/T2ZQ+8kksTYJnUR3xv1mfh/V61wKJifNVm5XwMT0rJPz0N+jtMz0cBT7tSiD4P/y9k
 fQhcF2buszAcvWhpYu9aJdWKviKjcsF8Rje59JQxNS9qt7HTJsgh0Ne7ZPUz8xpKRtOdyQ
 nCdrWInjckF/GuJIMORD5qmfJd3prorVnzCN///yd9/m7e+JEZZl1eZbYAxsOajFW7+oca
 SZehXGcGpvdEyDy+ocgHZY8UBvqYSmg/M2tr9xABWwhTcf0Lf6zyO9hchCZjT0MYMHTEI/
 VebIgdV0Tp9CUvxhGddDvO3liyyFUuj3dSgdCrMbvA5g+NAWim5c8vBDuFgA
X-ME-Proxy: <xmx:GVBSatWBdoVdv835kf-_Zf3NGdpCAOwMJR1ITk_CoyzK5ubuIgwjrQ>
 <xmx:GVBSaqhjA0alEtLWldNqGFRybY4HfAfYJP0D4kd40WjRJgpb8XpCBw>
 <xmx:GVBSalB8w97t0TPr2erEVJgIUdfA5nlAlaMmG2CH519Grm6jdv7wkw>
 <xmx:GVBSaotc6pwwCuMog4QaUhYf6L6niAWmrq99G7TJOsoWY6QARppVJQ>
 <xmx:GVBSaiWn4p2aaDNheeAuSC4FkzpsmkCnPRjTwVXPr07hKU0M503oS_Gx>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 11 Jul 2026 10:15:51 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Huisong Li <lihuisong@huawei.com>
Cc: anatoly.burakov@intel.com, sivaprasad.tummala@amd.com, dev@dpdk.org,
 stephen@networkplumber.org, fengchengwen@huawei.com, yangxingui@huawei.com,
 zhanjie9@hisilicon.com
Subject: Re: [PATCH] examples/l3fwd-power: fix missing return on latency get
Date: Sat, 11 Jul 2026 16:15:49 +0200
Message-ID: <VekzZJntTGeJ-Ln5Ca6vgQ@monjalon.net>
In-Reply-To: <20260512010900.340129-1-lihuisong@huawei.com>
References: <20260512010900.340129-1-lihuisong@huawei.com>
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

12/05/2026 03:09, Huisong Li:
> Add return value when get cpu_resume_latency failed.
> 
> Fixes: 4d23d39fd06e ("examples/l3fwd-power: add PM QoS configuration")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Huisong Li <lihuisong@huawei.com>

Applied, thanks.


