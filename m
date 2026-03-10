Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E14CEB1062
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Mar 2026 14:56:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6D49C402DC;
	Tue, 10 Mar 2026 15:56:42 +0100 (CET)
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
 by mails.dpdk.org (Postfix) with ESMTP id 466F4402BA
 for <dev@dpdk.org>; Tue, 10 Mar 2026 15:56:40 +0100 (CET)
Received: by mail-dl1-f54.google.com with SMTP id
 a92af1059eb24-1273349c56bso15886751c88.0
 for <dev@dpdk.org>; Tue, 10 Mar 2026 07:56:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773154599; cv=none;
 d=google.com; s=arc-20240605;
 b=V58/MxLrTMYOWM1DraEBwNtI2yM22KTwnyZtrgB6noTv1pXwJdmKzwzdsDgGS8x2Gt
 /95Ge37SlSQ55E+JFJAdjseyrBkqay4j+29Ey/HgMgh/S46T5/HI1OO8Zdd4QaRWK5Ef
 MsoXQH6uAhdB53ZbZgjsQDKAP3K9M8KUwPEH4NhI3Gnl0n+lBaMKdE6Ba42c6cMr3djn
 CBGaPXn6b2EwMhxQ+JX3sJ8Phq2HHeNScKPq6u4++M1FJymyQwfIpVYLfTyWaSvItfuN
 fS6Pf9Xk1bK8+qvHwsdq5LZfAElNPKztKw9JE1cL6dVM+aIuK8c1CrHy6A6A13Ulildn
 7DdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=WNQXZ4MzbYcTANELNIXL6Mao+Mg+iplBCFf41dKQzdQ=;
 fh=FU0Anb1Jjo5IhIO5JClc40ebnLQSsUjObW64xnZEc7I=;
 b=TEDDZykSeughJJG/ve7/xHNDi3o6f4O2r51BCurmRGsP+zrqDzOzFFRkiTWsTV/Fhk
 gxAAywmCwjrrlLC46C+BF9VYovYqUn6KOa/oXimtDl1COuFzNgkuSibhuTu9QUR/pCwI
 +ufyVuP40qcFM+tVWSotlkoUZCy6BLsMHV1k5ULuj+3GtZ+AdgEd44pwlfdjLrvDyRop
 UcIJBQGhCB66xtbe0y6zSScuKRFZmDGVKa96Q6u+5l8DuO/lSNVeHT1t6DMMARIvXH+7
 vDhNvc4yHLbnVs7rIczUAtKAIwAFXdiquNYh9hlunoh3LepL4+xXijLT6KVNnja/aLnX
 nxkA==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1773154599; x=1773759399; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WNQXZ4MzbYcTANELNIXL6Mao+Mg+iplBCFf41dKQzdQ=;
 b=T6toeuoV1lz9TBgmoBKAZ5CGQV5TBsi7939Re69SGk2FMnm3vLfsL9bTpiV5HgTfYG
 AIXxNiAdaK+X0snV761KbPfXhsZEe9G7aCvPVdf73KtjvqEpmbrFBjrMYLyTH7Rjwxmv
 wKuWBiW6XU9TSCIzs5naOm1pngoONPp7m/XNU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773154599; x=1773759399;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WNQXZ4MzbYcTANELNIXL6Mao+Mg+iplBCFf41dKQzdQ=;
 b=eT5R+XQ3YTeOLZbKgHhPSl1QzN/NRqnfM1s1RmR1Nn8O2Lrn6h2ZF0zoXs0s50irNU
 /+wWntBrx8U5taUPB4OI+l9cVufsjjG81qtpw6mw7HYQtzA+FFJQXql08R1238IzYeq5
 YYHoUnMm50oUw/eqFtX6m7h/lGStWmdHM4enJq5jCt/pDKhE1i9JXWnFkd/AA2B26Jdq
 KoWPsQksb8lrdOq+OFGI87KedI8b7NF0chIJB5Y5eBVLLgJzy+jit1u27EGTU06/Y77q
 V11bGYAnauIOParMPz1tLUD/Nn+JtAwmvPWRIAe/HNam0to9Gyu6p/g/dcgBG5/arTER
 LqFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWT5dDL7Q/JGWEX9ndfNjjxslwXbtbbmsVLM6o1UoxP9Qw0xebauQTj53KrrHK5pEj+rPc=@dpdk.org
X-Gm-Message-State: AOJu0YzMiMaUNxT65tNKJQz+PI+VLLVZgcaPgnixvi07/MAhiASNwiVa
 bMtcpYhxWU/f6bVn+fD+8+C+Wrl+xhcnWf8aiQf9YxI6mjIlrzzF216v08hg+xB2ClMNUAZjvgD
 fxpHFeUnDYfcW6xANJrP0Oj/u1+ftD45xpeJPLU690A==
X-Gm-Gg: ATEYQzwwYCIPVEP7YRK7X20u71t/FyAy7tVhnDCJoK6QYx6r9dV8biZBNZGDwb6i50Z
 qDV+2CetHP8l/Ts+hlHanuiDhSon/nwqUsm1lhPqCNFtmjT0L033RVb+iVtHeC/og2Y0Gt2LT8y
 xZOapatzghb+r0rE85TRdjO5oGfiNtuNAYtxf2M9ryhJRJb8kP9dN/fl97LIusNhCm0qlTuTlIh
 MHdby0xSUQ2CNdJS53YBSTNg2q7pL+9wTXVafazdR9vk310XaH5h9vbNGoyRdQu9ZaPZ8WDf/d7
 FsTm5sykrwHwJl93hL4WxWY7eGVVSRns9wTuVmQ7UNrwI+KP/hVWxPfUuTtkpbyeEJEq/PQa
X-Received: by 2002:a05:7022:4389:b0:128:d471:8c1 with SMTP id
 a92af1059eb24-128d4710956mr3580193c88.17.1773154599106; Tue, 10 Mar 2026
 07:56:39 -0700 (PDT)
MIME-Version: 1.0
References: <20251121195511.322005-1-abailey@iol.unh.edu>
 <20251217165716.705128-1-abailey@iol.unh.edu>
In-Reply-To: <20251217165716.705128-1-abailey@iol.unh.edu>
From: Patrick Robb <probb@iol.unh.edu>
Date: Tue, 10 Mar 2026 10:53:37 -0400
X-Gm-Features: AaiRm51J6dMYDCb4RWpu1rPBMw3pZGgVmCOM-zB4e3jD0oH4IitxNxjO3S_0YdQ
Message-ID: <CAJvnSUBd-Ywb5feeqQTDvVdsB_=4-BgdM5YkdGhOCTAJ2Gi2mA@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] dts: make one link the default topology
To: Andrew Bailey <abailey@iol.unh.edu>
Cc: luca.vizzarro@iol.unh.edu, dmarx@iol.unh.edu, dev@dpdk.org
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

The implementation of the patch looks good to me, but I think the
testsuites being reduced from 2 links to 1 link might be an incorrect
set.

For instance, I just did a testrun on cx7 comparing for-main to
for-main + this series.

This series introduces failures for:
port control: start_ports testcase
vlan: vlan_no_receipt testcase
vlan: vlan_receipt_stripping testcase

In terms of why these fails are happening... in principle the
functions flexed by these testcases should be fine to test with 1
link. My guess is we are uncovering an issue with the scapy sniffer
when running a 1 link test. The port_control testcase fails because it
expects 100 packets and sniffs 200. Perhaps this is because it is
sniffing both tx and rx packets on the TG port 0. We have code to
prevent this from the most recent implementation of the sniffer class
but maybe it has a gap.
