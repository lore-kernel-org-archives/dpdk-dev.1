Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7435AC369C2
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Apr 2025 02:13:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6822B400D6;
	Fri, 18 Apr 2025 04:13:46 +0200 (CEST)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com
 [209.85.219.42]) by mails.dpdk.org (Postfix) with ESMTP id 03579400D5
 for <dev@dpdk.org>; Fri, 18 Apr 2025 04:13:45 +0200 (CEST)
Received: by mail-qv1-f42.google.com with SMTP id
 6a1803df08f44-6e8f06e13a4so24996816d6.0
 for <dev@dpdk.org>; Thu, 17 Apr 2025 19:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1744942424; x=1745547224; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MH6Vyzg37ukkaH86o24jwLQuYiFgXAGjtzie7BPzTP4=;
 b=DgmjXmgpTwlHF55OVsuRujyGuZ0J1wEuRp7lz0fA+pVusE6Ivpb+Z7mGZAFbzzOKmv
 5UI/R02R2S9LE/3R9RSxxLFv5/fphf8I8kY0CQ3Zo5VElE59Jbeev0NxUODk3tiQGZYv
 LAJSJJMaxDv20ogJq3Q5gVY45j+jKjXuBI0hxLqPNbB2CobZhJ1XPG0U7Ht6DWM4MvFe
 aZ/CT8ZS9VTf7Od1BOT85cGjanNuSZZ/3rCDHkFe77sgeRGhNLHH4KM1Mi5SaeV6gyDX
 YmsbGD6KCd6Lx+xN+vxdUGpNYSOzMARWa8W9wHFxdoyn/+j5ijIcnF0zMqFJruvsPYgd
 OTxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744942424; x=1745547224;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MH6Vyzg37ukkaH86o24jwLQuYiFgXAGjtzie7BPzTP4=;
 b=k3aWrpnelrOOIUaSW0r8cpsGIxzYTjHzfrzlmTp4GxBhuICtgtsAWGzquRUVoDCon9
 fMarRtY/oXtb04HYBT9FglGVgipIgdoy+nWTKR2SD87tRn8sITBpqh6qJbsSu7QAxTup
 OzGGIo7WFJR8dvKEfDO/4KX6WpCg0yw7nj7dkouaw57X5HhmB9ccnVKi6gFnwKBtMiki
 4pHh1YyjeBd4tYYPU1Izl9ZoSdQaI0RKx4OOfJrXbrXfTrd6FeA8rjDG3GP5c1OGm3Hm
 3PYK9orB+2H0qFEOBXIA0PJ1U6Nm3sf0o/WcC84xIHnsqdW/lkOXt0f33kwLdGA0a/lk
 iLsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNLHaluqkocVJxDiKod9xdaZdGcAqoz/ARABCz8D+BeFSqsWxxDLVt8KgfVeqhpYZ9bKo=@dpdk.org
X-Gm-Message-State: AOJu0Yzhatzq54AdA50RDjgVCrIcrocsv9/5r/j4fSqpq9t1WzE9Bu65
 Lg2yBkP8su5nwDSzyfRoDsYaWPqfbQQfas88rnXRZQns9mbzyEcMCeoEn48M6Ghe1jli8kF/Y71
 gG0qnOf8BBlLtCUnexabpweBIdOS4d60EbCLs
X-Gm-Gg: ASbGnct2it7CxUb2ycMqXCYZ/OZHyn7HilZ/5x/bdkpr9T6SKKkBl7ow63z3s/oveMI
 YlfqkIvxhlfFvk5BEtxNJ1JLaqHwZTmr849eX+R2iVwP+N98yooqbop2uPWrPla5+S2p3HSm9g1
 K4AQlsj1C88PkMyD1E2okDdk9C5Os4Q/pq20GIw5078uVGAr8iB3UP
X-Google-Smtp-Source: AGHT+IF0cLYTghBhF82l1rLQULHryAd1QNbJEhrgABdbgpMpUsa5bapSE/ajjvIVD2fxnGvsfF0mv3iDklp3eRjCigU=
X-Received: by 2002:ad4:5cc5:0:b0:6e4:3478:8ea7 with SMTP id
 6a1803df08f44-6f2c4d6a466mr19582616d6.4.1744942424147; Thu, 17 Apr 2025
 19:13:44 -0700 (PDT)
MIME-Version: 1.0
References: <20250416061034.649607-1-david.marchand@redhat.com>
 <20250416073716.0a4e3b4a@hermes.local>
 <CAJFAV8wiK6qwdX6nVkd2Urf670VnQ1DDHteiUGxaaKE3CPK1mw@mail.gmail.com>
In-Reply-To: <CAJFAV8wiK6qwdX6nVkd2Urf670VnQ1DDHteiUGxaaKE3CPK1mw@mail.gmail.com>
From: Joshua Washington <joshwash@google.com>
Date: Thu, 17 Apr 2025 19:13:32 -0700
X-Gm-Features: ATxdqUFJ0FivddeMYdvcykX7inf7_Dr8DrlWhCvuMMZr9XRPS-dQNAuUWf9tAd0
Message-ID: <CALuQH+ViV6HWmmvgDaGBJ0JXwKDTH64Ve=pu=n2z4kJX=uP3yA@mail.gmail.com>
Subject: Re: [PATCH] pci: define more standard register offsets
To: David Marchand <david.marchand@redhat.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org, 
 Chengwen Feng <fengchengwen@huawei.com>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>, 
 Somnath Kotur <somnath.kotur@broadcom.com>,
 Potnuri Bharat Teja <bharat@chelsio.com>, 
 Jie Hai <haijie1@huawei.com>, Jingjing Wu <jingjing.wu@intel.com>, 
 Chenbo Xia <chenbox@nvidia.com>, Gaetan Rivet <grive@u256.net>
Content-Type: text/plain; charset="UTF-8"
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

Ah, thanks for adding that support. I can send a follow up patch which
takes this into account.

Best,
Josh
