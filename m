Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A22F6F41807
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Mar 2026 15:48:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8DB17402BE;
	Mon,  9 Mar 2026 16:48:34 +0100 (CET)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com
 [209.85.218.43]) by mails.dpdk.org (Postfix) with ESMTP id E7C2640261
 for <dev@dpdk.org>; Mon,  9 Mar 2026 16:48:32 +0100 (CET)
Received: by mail-ej1-f43.google.com with SMTP id
 a640c23a62f3a-b96e1ae843dso213110666b.2
 for <dev@dpdk.org>; Mon, 09 Mar 2026 08:48:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773071312; cv=none;
 d=google.com; s=arc-20240605;
 b=TrMxANzV+vc0+LAptKFhT+wAmzG4whF0aL0lnDovnyVA8KpPQSPwgVvQseOGUdCeU7
 IM4TP5+fBjNd06FTkVIugHHkDkHrZR+0ciXwC+AK9mttPO74hmkLDcEWiHwATDpyPxQJ
 NJ9LzYoAp9Bvn+507BN/MxX8IvlA3Qg5QvibG/3oiymIG9kHI5apIBGil11HvbYmTpC8
 ZjaSFtmq/tzMALeKo9iBiEmdOS1OES4mh0wC5eaC/1Go43317DYyV3+HjVtNOZbrdpqM
 qo6Ll/8QhwEe9y2WWvqsAjlpnYYd4a1knQXHQQd/LxhkqSo8sx6UF990ezzVzYXCbv0p
 ZFYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=dkSO4YUCzz/MXCmGS77NPAwC9gePI92oGLWeMWtnPP8=;
 fh=a99a0bXw0s1yLSZ+e/4zkUJNlZqhEmFBqB8tu7qTD+w=;
 b=fPPgI0mdBZVkWmXHot0Z6RtkKcE1EsBKh9FdILuujqg/HYy0bP0JVdK1ucw0xyuhLH
 CC7vchZGCPWPvsHOS5nFhFdLaIszM2O7Uf94ckkOodldTyzmcqpB5gV25x67vjljxV+n
 ACPE1ZuV1Oe6Dpt4n/U19P7zRTz+zT1PjrEkqh9aSKDLOossbCm5UE5qtjSXSKSB+9wu
 p1HMGEn6KVRMNizegSVif5CFT6WMdL4uGNx/nUXKEx6Dj+V9PAoKOCbQC6/ZuA5T3pDZ
 yFiHhcO013+iNFJL3fN+CMDNs0pOTzWDNK8YV6E7STQrO7Apr4uJqDl/dy7G6PRp+zM2
 g5VA==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1773071312; x=1773676112; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dkSO4YUCzz/MXCmGS77NPAwC9gePI92oGLWeMWtnPP8=;
 b=H6IYKjsNktUJCocPYmVImn+ROtrxGJycGcxiThx4vvlppFWlES7fCw/xemgNBj1aws
 mNQMppe0jHgNNv7qtMUTWlwtIfda+FqmWdA8IGmgGTtEaB62JCyPLej9Efy2VDqR1jCS
 BKRKU+22F4lUMxcYLtHm4iITFFfTOaIDE8uMs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773071312; x=1773676112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dkSO4YUCzz/MXCmGS77NPAwC9gePI92oGLWeMWtnPP8=;
 b=vBiGn8FEEHDZLX8w7YFd4pVF4FGIGyEy+Plm+yessoVZQaVUyKxJF+oGvHksKshpNp
 dsOGojCeGKpCTzR/CqcmeFC11GgI2XTRuUgNeAjKRtzNW0eCheMsyaxkowVdJkCdYKbb
 2w8PnCDdIw2QdUz7Ikf2BI6SXzd+oZeWZTkScL8b+zU/HlInmBtoMIP6koeSWUBwzCfG
 yD9jqE4cYqhPJ3E36s4dXlu6mED4pV0ef2XRcSBbKKRherIpf1BSOCuDE3k6sttmZZT0
 ikfHC42PSTXSQS0PXrV4oSOfHfOULmGaWDCXaaQGuzLoPw8U7Rr5ZqvWzIVwR3Wvqty6
 iu9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+8qdgRDZQJcykaFGjtktA1HeNQoVjYUWrYaoLck2iFS6HlIuiOJsMQDkUG9nVj9C2lw4=@dpdk.org
X-Gm-Message-State: AOJu0YwXfv0FYobnLr0FffO0KlVe2ujQjwPu2aAN8pFQfuucNTdsfJHE
 AwL4IGDcjPLzmHEu1VY5Aw4qV1/xrx7wEF+dn3eaFWApKq2If6YkuTIeJF0aqHn5zYIyxZFIwxh
 wjpw8Ed3cpE0sUJ2TDvE6YWo9lN/XYag9mXq73sohAA==
X-Gm-Gg: ATEYQzxcQnWkLtJe8le8y8bNaZXdbu1F5O9xVzAP4SBjij7ORO7vAJQ0Ecckzv5wc91
 M+EbO6w/Yy0x9MeFqGGYbSZkNOoQa36UEa2B7Lz2OJ+zIX5t+1ffksrQ9Eu9sziJEuivPHYBnkB
 b+NarPxgMUDvw1ZssSmgxTu2h57jAeWCZaq9WeL1Z+wEvbpyr2Xi/VW4pCmoRATy8Dlso7eCL3z
 /EvJbL4HL1S75wRkQVCDGnrHkXYSRVxy2cd1DMns9zAcQ3tz1De75XjM/rz3b4UyryZEI6ps64q
 OHgIHGQmvCmYZcKSMVLkXEs5fYjNiBgf/wRzHMegV05+2RWsh2k=
X-Received: by 2002:a17:907:944c:b0:b96:ef9a:7432 with SMTP id
 a640c23a62f3a-b96ef9a7c04mr296118266b.56.1773071312496; Mon, 09 Mar 2026
 08:48:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260220192510.37163-1-abailey@iol.unh.edu>
 <20260224163200.39360-1-abailey@iol.unh.edu>
In-Reply-To: <20260224163200.39360-1-abailey@iol.unh.edu>
From: Andrew Bailey <abailey@iol.unh.edu>
Date: Mon, 9 Mar 2026 11:48:21 -0400
X-Gm-Features: AaiRm50GLRyV7lH1kdglYxZwalAtxvAmcg2Wa1H4kjGG3TEESSgVNzBxJu8idO8
Message-ID: <CABJ3N2UAGrh3Z_dxje_Sh=OoM1sXXO19irFPA+nnFYd6x1qL5w@mail.gmail.com>
Subject: Re: [PATCH v2] dts: add support for no link topology
To: probb@iol.unh.edu
Cc: luca.vizzarro@arm.com, dev@dpdk.org, dmarx@iol.unh.edu
Content-Type: multipart/alternative; boundary="000000000000be3976064c995500"
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

--000000000000be3976064c995500
Content-Type: text/plain; charset="UTF-8"

Recheck-request: ci/iol-unit-arm64-testing

--000000000000be3976064c995500
Content-Type: text/html; charset="UTF-8"

<div dir="ltr">Recheck-request: ci/iol-unit-arm64-testing</div>

--000000000000be3976064c995500--
