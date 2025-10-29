Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDBACCCF9E9
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Oct 2025 06:26:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 23F2B402A6;
	Wed, 29 Oct 2025 07:26:14 +0100 (CET)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com
 [209.85.208.180])
 by mails.dpdk.org (Postfix) with ESMTP id 2F14540288
 for <dev@dpdk.org>; Wed, 29 Oct 2025 07:26:13 +0100 (CET)
Received: by mail-lj1-f180.google.com with SMTP id
 38308e7fff4ca-362e291924aso56230941fa.1
 for <dev@dpdk.org>; Tue, 28 Oct 2025 23:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761719172; x=1762323972; darn=dpdk.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=l+9C2BL9cCJoCW1UtUUUuO1vIGrxG0x0NCNqrQHKMZY=;
 b=BtEHFpC6qfsSBL1MkWKjFLYhw6IWEAxkyOhpXqIpqjRHTgBVyU5LVgn0K8HcWftsxw
 IaUr28P2wbOS8C/J1naogvJj3Xn6QlysqlEG0s0uBDs4ybMHeL1koJa20KxtSuyk4VyH
 jri+VLUVCQ5yL90olNTJjXxEWQACjALDWiqc9rftkLfeKaQeUX6xJkEyMk8hQjfN6bHx
 UzbNy2LgpAHW8vDepRKHoZ0rxC58ABtg33Bm5qOrc7PsdJOWLPLPmU633SVnsk+E8R3H
 3tADBHmGeQU5Pg4Pu1nNVn8mhW108CK+Amt6l+aw0KkgcrSPmUAfM8GWt0S5rkSDbM17
 Y9Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761719172; x=1762323972;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=l+9C2BL9cCJoCW1UtUUUuO1vIGrxG0x0NCNqrQHKMZY=;
 b=A2kCf/5d57AujetI9911yWX7m9skyYJDw29o3ky9pl0Eua97FsKCYExXiSbONa2d7g
 oFB6GHDTO8z0XD47SPRYLj6jDBhmuu5ur8sBxbxqh9T/2JfZMHJ1crn0V3LWnRnJmvAU
 YGuyvFoRBzBKhBo8EO6Zqf+PvMBZsqQ1jQ0n0KeR3/R38mprazvj1YnXsogdEhac84cD
 KqwH+ZV+3Y7uqs6j02lGTrjBQDYKSMbtoVY2dRfE3L4cdjJxoX//ginWkJdkhn8PB74c
 E4LTA7FiRcy7Jk7b8oFuRr+vMxqRK6/qpPnZ0gZM0A6W4stcxTzKH8LfOtOOoS+aCHxN
 fOCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMy4nZ9ZIrC78pSUOW928ZoIPf+Mb04tr+nSTC/74E4kL9dmW/AgSDgLucr9uH2hFJj4I=@dpdk.org
X-Gm-Message-State: AOJu0YyEYBEKCthbmJGt3vmPGem0eCIplfS/SNwHnBu12eh8E2buYL7Q
 BIirwoz45Fm2XqzLqu+rZxoylWWeXotZRQ/ceE8LGywLVMnmAyw6dBOo
X-Gm-Gg: ASbGnctTwX2qpP2PiRyeOoX7k7V/zRAu7aj8L0NEiNDmZ0fd0B3+eOsMmaQkZ1sqST4
 a9aDAfPS1sOk07u+yEAnBw27Z8ThyFV27c8TOARmOF4DQNxSd8I/HsAv9YWoDOEKEr09ix7py1Q
 mnrLx4/MVFMYZzNCZcbZ4FoTomJHcdDGUIftMrgPDuCKjbyrPL7YFm3HAC4SIW9P3iGdIzgJP5P
 zdnWmeDx9ScBu5i7t4S3aWanhjPdr4eelSTloNgQq6tFlJ32J2BNp6V4iY6hXWdT5Jldf4AWMER
 AhI51HtkUQ3N9LylNyX5RVj6+MUTbcylIhrl7Lg2Bqo6KdY5i5TeUandkYu1jqRiyil3DBJzf/i
 yjh5UtZyXYs47mjCSM+P1qcubaezoWOZih3vxBbPkPQhmD2sWV1yI6Pit0mpqIzp/aNRYBWkg6n
 bGrBZfESfuSpwn2K2kAKzvxsBwzWlkwbv/11d1W4FTuxqljfIAibjvwv7wNTz7tYdIow==
X-Google-Smtp-Source: AGHT+IFs+SlHcFAYzObs0ODdkKlvctKpJhXPISMt496A/SGktBJEP454pLvvIe9pU+VqFmT785FMKg==
X-Received: by 2002:a2e:bea5:0:b0:379:431:9d91 with SMTP id
 38308e7fff4ca-37a052e419fmr6014451fa.45.1761719172112; 
 Tue, 28 Oct 2025 23:26:12 -0700 (PDT)
Received: from [192.168.88.232] (broadband-188-32-202-29.ip.moscow.rt.ru.
 [188.32.202.29]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-378ee0e01bbsm30703481fa.50.2025.10.28.23.26.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Oct 2025 23:26:11 -0700 (PDT)
Message-ID: <1c5cad85-1408-4458-9e32-08f45f36c130@gmail.com>
Date: Wed, 29 Oct 2025 09:26:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Virtio-PMD in Windows
To: Ayshathul Thuhara <ayshathul.thuhara@iwave-global.com>
Cc: Chaturbhuja Nath Prabhu <c.prabhu@iwave-global.com>, dev <dev@dpdk.org>,
 Andre Muezerie <andremue@linux.microsoft.com>
References: <PN0P287MB25316B273566FD2CDDF0D83AC5F2A@PN0P287MB2531.INDP287.PROD.OUTLOOK.COM>
 <PN0P287MB2531616EDF3F92036B4E01DFC5F2A@PN0P287MB2531.INDP287.PROD.OUTLOOK.COM>
 <PN0P287MB2531AEA71C2E1A6B25D15680C5FCA@PN0P287MB2531.INDP287.PROD.OUTLOOK.COM>
 <PN0P287MB25314E093834DFBAA35898A5C5FAA@PN0P287MB2531.INDP287.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
In-Reply-To: <PN0P287MB25314E093834DFBAA35898A5C5FAA@PN0P287MB2531.INDP287.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Hi Ayshathul,

Adding Andre as currently the most involved Windows DPDK maintainer.

Virtio PMD could work in QEMU-KVM on Linux host with Windows guest as PoC.
However, the patches were never completed and merged
because of a few toolchain-related issues that no one had time to resolve.
In DPDK, the latest patch is this
(check also the link in that message and the discussion):

https://inbox.dpdk.org/dev/20210815145614.3826-1-u9012063@gmail.com/

In DPDK kmods repository, you'd need to add PCI IDs to the INF file.

