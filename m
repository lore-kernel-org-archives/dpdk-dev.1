Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B53C9C71135
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Jun 2025 20:09:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6B274402DB;
	Wed, 11 Jun 2025 22:09:31 +0200 (CEST)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by mails.dpdk.org (Postfix) with ESMTP id CB0D140144
 for <dev@dpdk.org>; Wed, 11 Jun 2025 22:09:29 +0200 (CEST)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-235ea292956so2563495ad.1
 for <dev@dpdk.org>; Wed, 11 Jun 2025 13:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1749672569; x=1750277369; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zPryED2slCUAGmSfEYSfk8eu2ziOZL8qdmKVnrIqWnc=;
 b=fFYCZayBe0GNqiRwvmOc8OQvSH8luJEC6waQb/wPJx2YJqsR1UjOua5ZV2ibfjSTZ4
 fUCReYKeZQtjvZ+30lKVVhzP4I7092iBGfvzjU0g/ArAJwevmN38McqIAhr+qGyrzC8G
 G0yu1Yuc8QugLYYbznDoMsMg7tWKzqA9MCYqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749672569; x=1750277369;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zPryED2slCUAGmSfEYSfk8eu2ziOZL8qdmKVnrIqWnc=;
 b=QGU9XkRfi3na668lAci1iSq4Gd08MclVBcTLhAegBoGYIFauMny3oKR622xU0OatF1
 82L+sGvJ/qG668n1Md40dgG/64EcSEzfRVKEGz1U4nduQKb2ltKwLFk0n5tDo+QQLstG
 jO5yuEPTLEU2ACJe/aj9B6kfTetPWaKctzUYNQYlTC58iuoZAUuMrrMmvHOQOlx6TiW7
 TDnj+RJp/CixaMrh8n4FfQs2zaNNmW7vmn1phpf9aiHkxb3+LIY5bnkwyxbzJvYzP/Kp
 ujt1CLrEle8LHWzx8uoIy7wCwWbF1SteACcz6ZDG73sPmmR4AMZApVVXgKdq9sn4AMEs
 Qrnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKwwYeQ7PuCM4HSlPHnPWwEJmXjmDmzWXHGI0HsxXavn4c2biMQqPntmszuClYfmNo6I8=@dpdk.org
X-Gm-Message-State: AOJu0YzQiPEjIFkxFrGQckhTT4nDE9MR3lH4W/sQTzMdP5a4P9WrQWUZ
 gNmqHC/ApEZjppJd3mjP0JwpCa1XK0gCYc6D3ZSdI0jPAssYlF6oKgVmTq305josKEjMx3Stm60
 X1ZuvEchdUhK1y8crNIQVz1CSicKLdFKZ4Qv7M2khdQ==
X-Gm-Gg: ASbGncv7pLkMZ0ZAAR3pp9vE50lxl2IEGq/K0mYZLW8v3Or9FAq6NGs7aL1PKFPrVSu
 3wFMdmSnYmO0vCuxqRJOmjG+lKwVwT/GfMLwEAwjrfw+/XRg+Q5xR9rrzDfw1ChON/+lwtpT4gB
 zjrFwbAy1SRnwP806Jmiwtqz4meqQvTPN5jc/ALtwFrtM5Ihy288oKCqfzvhXAaOjJ5ir9GQHUo
 oWG
X-Google-Smtp-Source: AGHT+IFBZJFPRuqoxRD3Lhem7yemimz2H9aUW9n5FTp5NznKAkpLSalCNEm21WrQTCPgirgb8S+5itxRgzXi0mnKIww=
X-Received: by 2002:a17:902:d4cc:b0:234:cc7c:d2fc with SMTP id
 d9443c01a7336-2364d8b7c7bmr5605735ad.27.1749672568878; Wed, 11 Jun 2025
 13:09:28 -0700 (PDT)
MIME-Version: 1.0
References: <20250610091411.2500413-1-vanshika.shukla@nxp.com>
 <20250611071039.2939950-1-vanshika.shukla@nxp.com>
 <20250611071039.2939950-11-vanshika.shukla@nxp.com>
 <20250611091546.3d5e101a@hermes.local>
In-Reply-To: <20250611091546.3d5e101a@hermes.local>
From: Patrick Robb <probb@iol.unh.edu>
Date: Wed, 11 Jun 2025 16:04:19 -0400
X-Gm-Features: AX0GCFsX5K5PS5rSrXclNMUxlcNJLUGKlp22dBpwl-PK2sKTNgxuYPGQZVpYzUA
Message-ID: <CAJvnSUBB_bJK2NJ-SemwAKoQT6FAy21FA-TCJtyTS3Te7J9eNQ@mail.gmail.com>
Subject: Re: [v4 10/10] bus/dpaa: optimize qman enqueue check
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: vanshika.shukla@nxp.com, dev@dpdk.org, 
 Hemant Agrawal <hemant.agrawal@nxp.com>, Sachin Saxena <sachin.saxena@nxp.com>,
 Jun Yang <jun.yang@nxp.com>
Content-Type: multipart/alternative; boundary="000000000000f10d0c06375163c7"
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

--000000000000f10d0c06375163c7
Content-Type: text/plain; charset="UTF-8"

Loongarch is spelled with 2 o's :)

Recheck-request: loongarch-unit-testing

--000000000000f10d0c06375163c7
Content-Type: text/html; charset="UTF-8"

<div dir="ltr">Loongarch is spelled with 2 o&#39;s :)<div><br></div><div>Recheck-request: loongarch-unit-testing</div></div>

--000000000000f10d0c06375163c7--
