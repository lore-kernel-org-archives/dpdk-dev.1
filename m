Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21DEEF8E4AB
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Apr 2026 05:19:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 03E8C4042F;
	Fri, 17 Apr 2026 07:19:16 +0200 (CEST)
Received: from mail-dl1-f68.google.com (mail-dl1-f68.google.com [74.125.82.68])
 by mails.dpdk.org (Postfix) with ESMTP id 035B3402A7
 for <dev@dpdk.org>; Fri, 17 Apr 2026 07:19:14 +0200 (CEST)
Received: by mail-dl1-f68.google.com with SMTP id
 a92af1059eb24-1273349c56bso365625c88.0
 for <dev@dpdk.org>; Thu, 16 Apr 2026 22:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776403154; x=1777007954; darn=dpdk.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:reply-to:from:subject:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pM8NXpvAlfmbl6rbXBAYSAGbScMvkLKtHRcQJuLsnV8=;
 b=Xoa15VII3Ouz7MQJdmBk+h3Np03S/8x01LYuNQ8ICaEn3UCKZhx4IiOJs2hSFiSegy
 odvJrXuIRs6mRfbrx0oP7rQZUnqQebOYcDxfHsg3w3LEMFSmNjmRsB8AQ1cj/vrfrP3M
 Hg7K+YK5X6VhP8XFsTQJuXq0SqdJ8TMunbY9iazGmE5sIwLK9l3jPV3U+K3D9SgMkfwL
 AO2vpxgDbNnHSufAy/USPMNgLOIr8/ckmjjkJBVJ+ou72vpxtbvpTUnRjwqE5GU4QP7f
 6YVmuFrYfoQ3DHPf+HY4SwEXU3oKxt0Y12R4UDF1476ji8CVc0CWbuM/LwinOEq5w2ej
 tMbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776403154; x=1777007954;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:reply-to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pM8NXpvAlfmbl6rbXBAYSAGbScMvkLKtHRcQJuLsnV8=;
 b=ixRXXcD+dsYJCdCJZ8QWIAcbtdXwrImYR2fIgeMcCK/VpDcF7c+Rm4IncZUUidQHnq
 mBzyjGEz0dp2/qAOnijQB8MHsQTsk5nrWKx+lvsOb3QM5+VYLRtA2glLgUexp938WLJb
 6sbAhNyPHfkeJapoTPATgCDJDZgD+8ueFrPyonb47i7Ci6l/ZJ5MOhuTZbW9/Z1HMq7a
 QeVIAHSazHZ9+LqPnTM+fGbs+7baJNgVLzz0w2p39DIbLj8J8MYXZ4GB1EHLRX2kwANM
 MuTIvy4hQzwJJ9exE1Mui0qIXEiD8jnmpbT/HjuktvKtjVuqgXnDmbPEA12yUzYj4xkw
 LLlw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9ZyhYXI0bE1t7N0BfB7XbZY4KV9K746GEh0JFcx284sRjvZuLDYjDis9F6Dw194/87IZo=@dpdk.org
X-Gm-Message-State: AOJu0YzAED7of1jwpWQ4oAF9sb+2wR+8vx5nLnwwcKeQlPwkMB5+9pXt
 eGzBx9LxTs/MI/GXfGrG5bi3v2ruYnMDRJuaL4wdLcn8hiSzSNj6Ehgy
X-Gm-Gg: AeBDievuic0CcSCNkXbHDIraMQescXwVfQpTr84n4GkirtKoeQfMmllegUdm10yCVZ4
 VjvUaUYgijN4fdFOZQLIsKUww4e7tF8YfbxZfQpUjl3Giv2tG5wUFkdslj/r7PFPmBuUu0opKGo
 l99nVc359lFREOCnIXwz9PCrYwavGS1gsZgftOj9O46IE5tjb9aiLAws3RTTWJKtCqqVJCJ0B9O
 qOKYYTLtil14Lye4WkCjSp6JuncLw8kMAISC45vc2Yzb6JW5c+RuEaKths36fCZVnQTa27GFBr/
 JfQO96ccKNvq++m0cieFy/dynKVdja4v/dJI5iHetxj499WmdQ6mYg+pGEyvLoT39DT+dwgZ2Gb
 pvI65MwQpwtYP8JhBYXDQ7IHLtJCgcsFdPKRVVKTlWgeNtEULHwfBV9Hvna32sRBtEIxyjCEpCb
 inYc0l4ttPxvfCb5MohiJrNKj9ZqJNSb5bGbiuP6m/zcrN5CjLNEwHwS+XSxldh+cbui1mNZLDM
 nVJ7sJJ8i9Q
X-Received: by 2002:a05:7022:383:b0:128:d4db:447a with SMTP id
 a92af1059eb24-12c73fa73e6mr618874c88.29.1776403153619; 
 Thu, 16 Apr 2026 22:19:13 -0700 (PDT)
Received: from [10.177.177.78] (c-24-5-101-44.hsd1.ca.comcast.net.
 [24.5.101.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2e536e54562sm818670eec.0.2026.04.16.22.19.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 22:19:13 -0700 (PDT)
Message-ID: <c0451147f1b2b7ba217c8e770e806e4a45f3e374.camel@gmail.com>
Subject: Re: [PATCH v5 v5 2/3] app: add topology aware test case
From: Sudheendra Sampath <giveback4fun@gmail.com>
To: "Varghese, Vipin" <Vipin.Varghese@amd.com>, "dev@dpdk.org"
 <dev@dpdk.org>,  "Tummala, Sivaprasad" <Sivaprasad.Tummala@amd.com>
Cc: "konstantin.ananyev@huawei.com" <konstantin.ananyev@huawei.com>, 
 "wathsala.vithanage@arm.com"
 <wathsala.vithanage@arm.com>, "bruce.richardson@intel.com"
 <bruce.richardson@intel.com>, "viktorin@cesnet.cz" <viktorin@cesnet.cz>, 
 "mb@smartsharesystems.com" <mb@smartsharesystems.com>
Date: Thu, 16 Apr 2026 22:19:12 -0700
In-Reply-To: <PH7PR12MB859698AFEFF656FD908A729882202@PH7PR12MB8596.namprd12.prod.outlook.com>
References: <20241105102849.1947-1-vipin.varghese@amd.com>
 <20260414193850.1696-1-vipin.varghese@amd.com>
 <20260414193850.1696-3-vipin.varghese@amd.com>
 <PH7PR12MB85969978BB6EB2C2E9034A8E82232@PH7PR12MB8596.namprd12.prod.outlook.com>
 <PH7PR12MB859644299B4823DD03A125DD82232@PH7PR12MB8596.namprd12.prod.outlook.com>
 <PH7PR12MB859698AFEFF656FD908A729882202@PH7PR12MB8596.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
MIME-Version: 1.0
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
Reply-To: giveback4fun@gmail.com
Errors-To: dev-bounces@dpdk.org

Hi Vipin,

Pardon my ignorance.  I am not sure I understand what you mean by
"current function test format". =C2=A0

Can you let me know where I can read about the current function test
format ?

Thanks

Sudheendra Sampath
