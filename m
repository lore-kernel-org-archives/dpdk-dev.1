Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84FA1C77B7C
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Jul 2025 15:35:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AF50B40267;
	Thu,  3 Jul 2025 17:35:28 +0200 (CEST)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com
 [209.85.128.178])
 by mails.dpdk.org (Postfix) with ESMTP id 92E3640264
 for <dev@dpdk.org>; Thu,  3 Jul 2025 17:35:26 +0200 (CEST)
Received: by mail-yw1-f178.google.com with SMTP id
 00721157ae682-70f94fe1e40so13435867b3.1
 for <dev@dpdk.org>; Thu, 03 Jul 2025 08:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1751556926; x=1752161726; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AgJrHBef5zcwd3I3J3Xb1mLyx7oYkhB7tM4DtxaDFMo=;
 b=Nma2EeMMyqsOKUo7kA0t6j+k3BJ0GUyMYm2I4dE+CNFPgsiUlLW32/CKhijTFimrrH
 zIpHnNlmSp1rfhiaRds2L73Hxtn0bfLZbNsZ62ifLLMSTQTaQZnTDK8Itpgi1sii4R4k
 /xxZOfj1gjSWG+ZhIzbiC+/9tzRWH+ouMPv7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751556926; x=1752161726;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AgJrHBef5zcwd3I3J3Xb1mLyx7oYkhB7tM4DtxaDFMo=;
 b=EerSCrxJXflAKYwotchU1dTsD2EgHcKjPWK5Xe5MQE3WkxaDG+5y7kooTlRRB0fJ7S
 6g1YWlckbzzJUBx9bJGxqKbRMYj1SNUObOIw/JB9uxG3qJAyGbG5YhGt/GzK2J5JAgWN
 Vc6QgEFEBpfs6dPA60qFeLcEgW22HAMfMcm2PdhzpCSwT3iYP49evgZZAycLwLHnY6ZP
 MiG+2ZPLtGLZh+xOeidc4gqLkvgOnQEEQKuF6felc9ZPk8Rtw9u9di2YSYh18L2cDCjM
 kauMffFVlUpGLdHm3LnX1aeGNu76Mp9om4xIROdHN6DFc6FPNVONIW68xog+nnxj3y+E
 L4Ew==
X-Gm-Message-State: AOJu0Yymlmr/5ehOcmIFnHtQh9AQbomJyoW1cCmJ60YA5VJY41bQOhZK
 reyzGmUKWT9tSxojROJI4Cp7nbxRM3Na12SSLOANodFCvmHX+wRqWhXizPV58mO3FdKnzPviDro
 SIac1Awccoeto1heTLsFWaX+iEWIRkpqvH0BtVsevFg==
X-Gm-Gg: ASbGncvmqnNMhWNsCa9CEVf5Gf8K51LSyDofOr1/U+uO55vW+3vXIKSyg1RAKpFW/E7
 L7L0QOfZqwdJKcbhGV3ndmJOjIBIwFpHuXEeE19XynUv8N9MjvEU9Unj+MAFXS34MbgNumG77Qg
 zb5nB3V+p0j2kK7NkCkmEcNeE+cCFe1YWMo0Wp7GDC4AeyOmX3C+ubkjgMJuskCHN8dE6Hj81z5
 SQSfg==
X-Google-Smtp-Source: AGHT+IHvLA3Rz0lTBSkXOzfbmxBN94Q2Gndq4kYkikYG6NDANd7iDC35iFtSNEZbnzzBifPSNJkuKbn0/BQGPzj7AZA=
X-Received: by 2002:a05:690c:4d09:b0:712:c295:d01f with SMTP id
 00721157ae682-7165ca33154mr39376737b3.3.1751556925868; Thu, 03 Jul 2025
 08:35:25 -0700 (PDT)
MIME-Version: 1.0
References: <20250702164204.607685-1-luca.vizzarro@arm.com>
 <20250702164204.607685-2-luca.vizzarro@arm.com>
In-Reply-To: <20250702164204.607685-2-luca.vizzarro@arm.com>
From: Dean Marx <dmarx@iol.unh.edu>
Date: Thu, 3 Jul 2025 11:35:14 -0400
X-Gm-Features: Ac12FXzFLDRiaj9l5rQD5gSv4A4F-Q1gfT8A723LXMxFYpcSpv98NaiEpR7sfmg
Message-ID: <CABD7UXMp+nVS3Zt2X3i6LcxY2bo4_xQ1Aw67Omz9EXuc3aySvw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dts: add DPDK build app helper function
To: Luca Vizzarro <luca.vizzarro@arm.com>
Cc: dev@dpdk.org, Paul Szczepanek <paul.szczepanek@arm.com>,
 Patrick Robb <probb@iol.unh.edu>
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

Reviewed-by: Dean Marx <dmarx@iol.unh.edu>
