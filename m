Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E583FC43211
	for <dpdk-dev@archiver.kernel.org>; Fri, 26 Jun 2026 15:01:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A49DD4026D;
	Fri, 26 Jun 2026 17:01:52 +0200 (CEST)
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
 [74.125.82.180]) by mails.dpdk.org (Postfix) with ESMTP id 450D940264
 for <dev@dpdk.org>; Fri, 26 Jun 2026 17:01:51 +0200 (CEST)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-3078e0dcd67so1805339eec.0
 for <dev@dpdk.org>; Fri, 26 Jun 2026 08:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782486110;
 x=1783090910; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FrauLUJSeUoiiyk0e+mDBD0JybzFwcGp/ic3/FUbgh4=;
 b=ZFAr6rljMnCDlVIhEL6cca+fuoIW4vUPbe6KtaoFtYL2Kz/Vd2iZaF9Ab9yO6YDu8r
 ugyax+eZtb8Vae7azTK6FLriWCYPoybqMX0kPnNkhObg+YwAtYDs0S4y+JIwu2WXJnMS
 nY6J4EX95swkf49a8D9cQYmDmphb+2rcRc2xxfvPNLnDrCatBowC9pomCZJNRht3TMEX
 IFEiKqBHTbsBk6U5C4Wu1/16tWc//Cy6SFgFdr2BP5tPh3TXROp5DTmJzPurXSgZ8ftH
 hRv+JLswzdbPt+p5A8rNWaf2VohuIqMIEGStYWCEGUnKHaDM4ba/vgFzrQnfdrbMNmTV
 O+Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782486110; x=1783090910;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FrauLUJSeUoiiyk0e+mDBD0JybzFwcGp/ic3/FUbgh4=;
 b=Cb5KmxoNMcT4NzqiV0OoPSqU5+I11tnymRz/lTWOtOlcm9fVEP6koMaLkPRYDtfTst
 T6lguPcAx2+A2t3clcdoWPZCZ1d7RNW/d9KtME06Pk4MFUKJKo8Jdf0mbhjCdJbrMNaz
 SO5NxVDGO4gY0Yy1D/zkW5iCS21hhplbQAubjvsDzyl1dQsOOkmTL+eQ6O0X2E66TRY8
 Jz8ifqUgCHgwxs7Jqr4+QxBo5MWwBsmilXC8oWxhT6/SEPRzmRAHEQPPFuHI9rhXrl/v
 3qeL6qlS9jK5mnFCk6iq0+5RzEJU8Zrj1DoduH8ViZefH2pMzO9ESE3GAFx7uKFcWmEd
 mSPg==
X-Gm-Message-State: AOJu0YyV3kyZrot8hYptiVKhneo26Y5Z9yD9adDu+vIWJrNdhQpj61g2
 zTAfkIoAd20NMsdyevVETrndKpsWWoPaOizhUZT+IfUqx/EknsoMPAKvTmE7e5qqUY0=
X-Gm-Gg: AfdE7ck+v98mTjov9fzgiIcCqLCnLlcSfmg9ysQZmZ2ufoGavL1+cfW/532ydH5Mn2a
 nGEVJiyXggvtfhqJWPulHdUmCtRzhe1E6WbcQ2UeXWhSC5EUm7UWOqjkqJxTX+6ChzP5iws3r2T
 0cQ5hArhravxiT/7ttEy0JQzo1hD4J5ps6HgbpzQzPzWXKEWqXyBAnhZkhluE/Cw8FN3/l1O6/P
 m8cu3wILyLKMcQ2uyeZigUSg+/xVBmiW7ra3vRMac/U8CbRaPmXHzk1xCWWOPZtdTkQHpBE63YH
 kUe88iHXZSJs5ALq/fxBcYyzNY5sidXcEKVSPcNLPKrd27R1w0xewEx6GUm8j7QBia2goKEXmlp
 /z7696PmP22FC4H2JagGrIodoWNhjeIsQsawPEftVqOhHtPH0Fqwhdl4dvBnNS81CPf9v/K+JCF
 rgNP8t3sm2GZ/p+AzIXHdATlg7o9bqMwrLrI0OazUXsAZN+RI3FCrd9vil3Rr9In4q
X-Received: by 2002:a05:7300:caa:b0:30c:ab4d:3820 with SMTP id
 5a478bee46e88-30cab4d3e2dmr592091eec.44.1782486109697; 
 Fri, 26 Jun 2026 08:01:49 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c8b1ae5sm21164813eec.16.2026.06.26.08.01.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 08:01:49 -0700 (PDT)
Date: Fri, 26 Jun 2026 08:01:46 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Marat Khalili <marat.khalili@huawei.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [PATCH v6 0/9] bpf: JIT related bug fixes
Message-ID: <20260626080146.5b24006b@phoenix.local>
In-Reply-To: <cf0e1f65fc574f2a9ffebd5fac7ca60c@huawei.com>
References: <20260608203322.1116296-1-stephen@networkplumber.org>
 <20260625173231.216074-1-stephen@networkplumber.org>
 <cf0e1f65fc574f2a9ffebd5fac7ca60c@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Fri, 26 Jun 2026 10:35:47 +0000
Marat Khalili <marat.khalili@huawei.com> wrote:

> Series-tested-by: Marat Khalili <marat.khalili@huawei.com>
> 
> (Maybe it actually deserves a release note at this point?)

Maybe just a single release note about BPF enhancements/fixes
and add sub bullets for your loader and verifier changes.
