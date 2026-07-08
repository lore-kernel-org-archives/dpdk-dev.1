Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F11E6C43458
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Jul 2026 01:16:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 186A040264;
	Wed,  8 Jul 2026 03:16:17 +0200 (CEST)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54]) by mails.dpdk.org (Postfix) with ESMTP id 8180940041
 for <dev@dpdk.org>; Wed,  8 Jul 2026 03:16:16 +0200 (CEST)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-493b1710405so435685e9.2
 for <dev@dpdk.org>; Tue, 07 Jul 2026 18:16:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783473376; cv=none;
 d=google.com; s=arc-20260327;
 b=J26IQ/tqq5AuwZB4NNFPay+UoSn2YF3Zrat7oeYgaCg5Q8lGQ3YY1spVuLSH9O3XK1
 ZS/Knpj2iMMozdaXNSNTBl5/Og2b3qECcRleq4Ccl0bp8yxSHi5aW4sgMgKQplDY+PA3
 ooveCXpDLApyeJHYtDizFFDuEvyBfzfKRxPeNnnLS/jVAR/zJ48qmyQMsof0HAA2UsIb
 DRkeYVbPmFf0AbsUAfQ+uxtaL/2dQpIgqEC725FhOFnLhNOobew9KH/kSvHcUSsMSoY7
 TMIRAPOkeqb9HKpFEveFn+KU0bRmDS2umnUXMMDXc41ipwgN6S2Axpj3PZwv2n72UaOa
 VH4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=wPQ6/tnN4PmqWEjlTg3rncOzZSjVeEn+J4o69s0zJN4=;
 fh=mUvhcYhqc/yPYHJg9XdJS454iTo0Vpvj5w4IhOnOOuM=;
 b=Jx1Bow8IY/zyl4oNR3Qw6im33bfng/E1y8NWkbTRQG7e+W9XXFvYsQHpvw6fC2+J1z
 S9kbS/UxpVZZ72D7kknALPmUCP+3plYQ9VyCRiPzfbBqaQJ4QG/fbJKxn4arOG5cTgV5
 FXvBEsjKLjvSTpPVpXKgdauIoCZM4Xe2yblSw4pWC5OZTx/NwsK0c2OUb8Rpw/lmyKes
 6xmsiInzZenYOInVJSnaxXeBTRLBA9R7ziXJEgZfc2keQZcEH/Y1GC8EWpEs1XRewwuO
 /e+j74GAfjNf+YNVcE48EuRJTg4N72rF2lKw47bnNouaFSdSAFOP4PypSEmCfYco0Fu+
 REJg==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783473376; x=1784078176; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=wPQ6/tnN4PmqWEjlTg3rncOzZSjVeEn+J4o69s0zJN4=;
 b=q81w0KNrwWNVdLn0eie/19RFUepXTbf4gSKSLxqr03esyy3niM3mU+wURkWOy+DhQ4
 vFdSQbFzU48qzi1ivaRbMxsjH/7ZF+msHDBXtSexg8c5YqXgnIcOAdi47lbinm0LnngC
 pCBvxMtBIdkpzJxL/qF9U4CnM01Jrzo4+Ldyp9ZRwSRMJaNmbbi02Hw5Dnn5a+hP7dP9
 uXpQ3Yy+EEv8542Se8yUcFzpB4ie+MYjE4fjxRnni1CjP6iHLUMvMBv0Srx6/wLKI0gW
 9k4rK4Plj1PjoQD+Y33KyJGC3RUPluQ9HLBfHB65lB7wx3fFHxG0iOR7v2mQ4fhhvCYt
 TCew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783473376; x=1784078176;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=wPQ6/tnN4PmqWEjlTg3rncOzZSjVeEn+J4o69s0zJN4=;
 b=Y/R6XifL23rFgXWX3gRCj1YGEUtEmctwZaDM29J8xjJstnIJu9dLo/qu43SmBu582K
 Tdyj0K+zyKv/S32Uh65ihJomc0htex6HhtsNBJ48TjADIYxD+dHk5U7MUPOGSJ/5g2qb
 7axWRaDPEmosIWueC0GvCPl43C6rdL3ydUTRZRFDShdFjhs0Ci3KbKXoFcNic0q1lZcu
 SEBvUE2jc4Y66jElpkCVQeZjIi5rU2vYrX6If1mQr9FicMj8NyGpuoB4W/tjV63TWqto
 iqtZ/ErukRtHO5Y5W/TRVq139uyw1Pi9dUVwbe6N1PvUce0G6cAYzkjox4rewxbhmXkT
 +rrg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrnKHTfF6n8ffjLZDeZ32nVn536YtiSs6IzhX8HHsPyVnwnBo9LwUy16IZpgPQcJZ/wGHE=@dpdk.org
X-Gm-Message-State: AOJu0Yzj6SgdTwpUqefNnGVgBgYx1Wro+OsQW9ESSoou7lF1PLs0F5cC
 dUqnXAWD79LRHLgLXlrR/GCFyVDjYzsAeN6tyczsSRPtoWyNOw6q1ixkWfTLWjFxzW67lppo/cU
 WD8FGPrQ9QkctANoDNakcMD9WDQ1D9bI=
X-Gm-Gg: AfdE7ckgJjviIrJyk/ZQyO+b/CB2PhdEJBVltfHviPjRDHHkOK731Rj5MLBeEpUAQJk
 1cioj5r9E8dIErpRjJ0tBQpG9qJS3OUwnn43LO69TQ1Gh302XRBaWdprF8Q1NKz77yUUMWGP89B
 EtGHH6H20Rp1l2HEOL9gs2CjsDQBf9hZVxt+PCI8i32Vb0TOUTg0EkwWnBhKRanriVZnCsYMqac
 HZpoHzC6TJ396N+HhWxUTaaohxv5T+zTsOytkyuCEj+dbxBNdXWsNKG+AcDto5kcDzYzR/tCw5Z
 drkDRKFC8aqEF3CrAbz8Env9YRsu1JXyh8BjnYFn/BnZAmuq42jXnbqJ
X-Received: by 2002:a05:600c:4745:b0:493:bd67:316 with SMTP id
 5b1f17b1804b1-493e684b001mr2136545e9.16.1783473375985; Tue, 07 Jul 2026
 18:16:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260609142330.1423729-1-knimoji@iol.unh.edu>
 <20260625172233.2288663-1-knimoji@iol.unh.edu>
 <CAK6Duxvkpxh8XzwvmMaX2y=Am2ePXD092JwX61H5EizDv5f2Gg@mail.gmail.com>
 <CAKYPG+yPEA2pH4hv3PHDGkVoc=NggT4+GWrvLg0E3V4JvRLBVA@mail.gmail.com>
In-Reply-To: <CAKYPG+yPEA2pH4hv3PHDGkVoc=NggT4+GWrvLg0E3V4JvRLBVA@mail.gmail.com>
From: Patrick Robb <patrickrobb1997@gmail.com>
Date: Tue, 7 Jul 2026 21:16:03 -0400
X-Gm-Features: AVVi8CeCL7Ss_YX4YZoBCcUEw9ZJNjTvwdUvZHrXyLPfEZveCKBg7jvayCNzSHU
Message-ID: <CAK6DuxvoaE=SBv8SParRR0CmFdGHgJNFq0ydKxJ6nO7ft+xOjw@mail.gmail.com>
Subject: Re: [PATCH v3] dts: update dts check format script and resolve errors
To: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
Cc: luca.vizzarro@arm.com, dev@dpdk.org, abailey@iol.unh.edu, 
 ahassick@iol.unh.edu, lylavoie@iol.unh.edu
Content-Type: multipart/alternative; boundary="0000000000000ac1b706560f41a4"
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

--0000000000000ac1b706560f41a4
Content-Type: text/plain; charset="UTF-8"

Applied to next-dts, thank you Koushik.

--0000000000000ac1b706560f41a4
Content-Type: text/html; charset="UTF-8"

<div dir="ltr">Applied to next-dts, thank you Koushik.</div>

--0000000000000ac1b706560f41a4--
