Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E046C35FFF
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Mar 2025 17:44:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9658A40151;
	Thu, 20 Mar 2025 18:44:11 +0100 (CET)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by mails.dpdk.org (Postfix) with ESMTP id 15519400D6
 for <dev@dpdk.org>; Thu, 20 Mar 2025 18:44:09 +0100 (CET)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-2260c91576aso20570705ad.3
 for <dev@dpdk.org>; Thu, 20 Mar 2025 10:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1742492649;
 x=1743097449; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DhxliL967a69cBwiLD0WQ4ZoGLzXgcQmhbq1BlMxeKY=;
 b=NfbaCz69bilT/YSDpdShm7Xv/8VEHEypB8xIb2b7MJX1BOkicGifKOzOyaIjwQRz8D
 k/uzfW5JnqMbLMUy/0gCV/vrh6fXd69MyBpOM2tacmEfLUuolSio98G5ideakOR90vNA
 IglNj2Kep6m7FuMfPcWoPpolAXyWmORoiQYiaUvlLO09LYCpxIgsy09LjIxzFQ0CDouI
 uUHNbYGuq8QjIG73xEdrZAfhGUPpDpi5ei3F2FlOqt0LvohlVF9LgRQMwQlBtsDbjZLG
 6Uzo8Hotx+bGFCjuLye/LKCwWO2EI5infYahllZ7Jq27n8FTmx/uDAvWn68kvPxJDX69
 VFdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742492649; x=1743097449;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DhxliL967a69cBwiLD0WQ4ZoGLzXgcQmhbq1BlMxeKY=;
 b=IqC6uVdYghEjE0MI9HUP1QGj+w8hLWfldhffHw7Ew7o4Lnwayb5FRY6n8F2IgcOEnk
 stm+LncMpT3mJkhovtQC8SS3yL1zc4jO7t1f9VIUy4AR/CYm0J37Ht+7tS0ocUPnaauV
 a2rfjML8jf7eCefhiK+k6bUmccIYmQEC1qqBbrouyvUgaseH73nLw+pWO0XBcvjIF3Wr
 SA6wfTiI8rSDuwckQXxLTfkMYgSj8r0E4O09QN6PegRv7Q8m32z18Ap1tPEcfB68SJ3J
 OMw2k46I4GAKHP4wG0PIUlBF6Pkt7Ca8YhvwpZ0xR+XxBpuAsHdyyG1s4/UvxFb8CyhY
 hlfA==
X-Gm-Message-State: AOJu0YypFGVn+YOwxEbtAoVV2+rQVMQVzlJPsSO7WF4dLjCMNnBTfLeh
 T7NKOMtgMT66q4VKWlGvI2fZtaNrd85ZxgkNYOXf2swRO8v/zqb7rCyGJwn7n3o=
X-Gm-Gg: ASbGncsJGffyobaVsNZ8jCyjhFwEeoLACAZ75UN8WPMdER8dPP1cudwxwr4Lj5tSQ6+
 AgvTAdz9R/qRqYoMfMu/G2i5NsLDH45OWzK6gkzQTjgT3B1NKYmZ3akiuCVn4kVfz6Z4SlA7bXk
 leUko/mRK1wETkPLwovU5pWQ625r5IfQxS80vY6ZIzghWUD348Vn5SJElgRXL6leo1FGX0iJ2eR
 h5hvVBmGRW2iJ5E8bjcodvRCayMEStrgGYqIKI83jwXQqHBGWlqQ7RnhsKo49Bvh7UXFUDkXbmF
 6ndLZKusXGMVwWqZe711Ck9VgHniS6kWPN81ZSzEtmGPGmnwSahQdrMU4zhFqGOzmnLshroDYOi
 cVQjHcGy2mYXWZ7nPNI/yHw==
X-Google-Smtp-Source: AGHT+IGu7rqP/VEPpOEXjdOhDilgEKQMYhl8Q8yGsaHIB5oZ6u0a1DWcg+p2GUUezfbrpogCgA1amw==
X-Received: by 2002:a17:902:d549:b0:223:619e:71e9 with SMTP id
 d9443c01a7336-22780c551e8mr4978565ad.11.1742492648999; 
 Thu, 20 Mar 2025 10:44:08 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-227811bf5a8sm599605ad.134.2025.03.20.10.44.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Mar 2025 10:44:08 -0700 (PDT)
Date: Thu, 20 Mar 2025 10:44:05 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: "Rajesh Goel (rajegoel)" <rajegoel@cisco.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: Dpdk-pdump not capturing packet for vmxnet3 device
Message-ID: <20250320104405.5d3d405d@hermes.local>
In-Reply-To: <BN9PR11MB5354FF359EB7E5609CB494BADDD82@BN9PR11MB5354.namprd11.prod.outlook.com>
References: <BN9PR11MB53545D51138B2F27A402659EDDD92@BN9PR11MB5354.namprd11.prod.outlook.com>
 <20250319092753.210e92df@hermes.local>
 <BN9PR11MB5354FF359EB7E5609CB494BADDD82@BN9PR11MB5354.namprd11.prod.outlook.com>
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

On Thu, 20 Mar 2025 09:38:16 +0000
"Rajesh Goel (rajegoel)" <rajegoel@cisco.com> wrote:

> Thanks Stephen.
> 
> I checked this module is not present in 20.11 dpdk version, but its in 23.11
> But can you suggest if I need to port this back to 20.11, any necessary steps I can follow or any dependencies with the new version etc,
> 
> Thanks
> Rajesh

Too hard to backport, you need to not be running a more recent version.
