Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F0B8C83F17
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Jul 2025 18:37:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B431440B8F;
	Fri, 18 Jul 2025 20:37:58 +0200 (CEST)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com
 [209.85.128.181])
 by mails.dpdk.org (Postfix) with ESMTP id 8505C40611
 for <dev@dpdk.org>; Fri, 18 Jul 2025 20:37:57 +0200 (CEST)
Received: by mail-yw1-f181.google.com with SMTP id
 00721157ae682-71840959355so26787747b3.1
 for <dev@dpdk.org>; Fri, 18 Jul 2025 11:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1752863876; x=1753468676; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NgaNmlDY54WgoH19nC53gIC5b/169v1ozuX2mFnF0/M=;
 b=cGRHo/uIFGjXGTKgHgguY5uTBCtWOUEwE8J4tftbaAONn9AFW1S9qI39b36Wf8v1SP
 BTzXxcCrhVtzXad+Sl+tTtmsC23GYTSYMTTfIv9sAx6JX3orKED1To5/eeBYffHLlr57
 YEpY7lgVAs97WvURHZ+mNB8bgJrcbZzfhd3hE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752863876; x=1753468676;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NgaNmlDY54WgoH19nC53gIC5b/169v1ozuX2mFnF0/M=;
 b=jtKAsOiTA//pQNHpK+wuofGvs3lqvawoq8yCIA2N85NlDiC2CFhqSuGDCUpdarR5ls
 ZidCBO2Zl3vyy9e5sPvGdGzuEOpoF+gez/Wviozybz4/pFtcH0mYv9XtW96qW5Lc8nn2
 ZGRO7JvAj0/0E+r+W34RpSBKG3TtXQSsicU7z1ARPar5PcSA4rvcYBd3IWhI8ozEc5jx
 ppkKBrobySnUgmqw4QwxJxqz3W240SbONx9arBKG9qOksNljzftDo7Jhyx51mX8oBF0E
 uRumaWkLmwtlz4jHCvRwFRTKP/OQh7oVFva2BsVhRSzQLLRyNfnNs9Y3iPea/W1yTKQ8
 VBFw==
X-Gm-Message-State: AOJu0Yw35OETzyPemGTjJIGsCo/iTmUtellvF+5mUvnL+O/k5x9WSdMY
 80GACXT6E6l6pweA1+2TtJAfw0Tj5U/8EG12roky62EdXLD7itAKo5H95QmDPUD9qu5bCMfUwHv
 1Lu1TqJ/+FENA1z+AxvozChR+rjqfNuYCD/uM8TPKAA==
X-Gm-Gg: ASbGncvZzlZ/nSgeHCt5I41UWtGwHcxDVyxu//BgeV044/t9l4oDKOfNQaqRmZ/dgkw
 qcc3liu+c/EmXEnqPSfIrLo6QSGwOimC/WerPzktNbFYV2LP+VWWmrM4KYIyQpGuALLZtPqMYqU
 zIL0kRSwWR1zbHcp6t+aD0chmCavAPQEc6xCtR7ut073mHG97s25C1TsS06peYQ/7TKnl4wvhTh
 XGtD/d9QNTYbm/29/bNJOs=
X-Google-Smtp-Source: AGHT+IExwV8iDZHYjjcvioBUy8aS1VyhCfjMDDOT1OL7Q+uLsvW6ln63hh3CsDgK0iQVF6Lcg3SVNs+A3+gffZ3sk5A=
X-Received: by 2002:a05:690c:a012:b0:719:4c68:a713 with SMTP id
 00721157ae682-7194c68b24amr49021817b3.2.1752863876543; Fri, 18 Jul 2025
 11:37:56 -0700 (PDT)
MIME-Version: 1.0
References: <20250225153345.331216-1-thomas.wilks@arm.com>
 <20250718150404.200096-1-thomas.wilks@arm.com>
 <20250718150404.200096-3-thomas.wilks@arm.com>
In-Reply-To: <20250718150404.200096-3-thomas.wilks@arm.com>
From: Dean Marx <dmarx@iol.unh.edu>
Date: Fri, 18 Jul 2025 14:37:45 -0400
X-Gm-Features: Ac12FXyjV4uMtO2Gr8UNv7WzBGGC94uF8F65I7q8AnPBbgAGAuIBFA3_lDTd5hY
Message-ID: <CABD7UXPyhmLKn-v7-8Wp=7fu3cgZSbVhgUzN=xeRNBKZjhh4rA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 2/2] dts: add PMD RSS testsuite
To: Thomas Wilks <thomas.wilks@arm.com>
Cc: dev@dpdk.org, Paul Szczepanek <paul.szczepanek@arm.com>, 
 Luca Vizzarro <luca.vizzarro@arm.com>, Patrick Robb <probb@iol.unh.edu>, 
 Alex Chapman <alex.chapman@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, Jul 18, 2025 at 11:05=E2=80=AFAM Thomas Wilks <thomas.wilks@arm.com=
> wrote:
>
> Port over the rss_key_update, pmd_rss_reta and pmd_rss_hash
> test suites from old DTS into one file including all of the
> helper functions that are required by all of the test suites
> to work.
>
> The rss_key_update test cases verify that setting a new hash
> key when Receive Side Scaling (RSS) will result in a change
> in the packets destination queue. These test cases also
> verifies that the reported key size of the NIC is correct.
>
> The pmd_rss_reta test cases verify that Redirection Tables (RETAs)
> of different sizes function correctly in RSS. These test cases
> also verify that the reported reta size of the NIC is correct.
>
> The pmd_rss_hash test cases verify that the 4 supported types of
> hashing algorithm used in RSS function correctly and that the nic
> supports them. The four hashing algorithms being DEFAULT, TOEPLITZ,
> SYMMETRIC_TOEPLITZ and SIMPLE_XOR. These test cases also verify
> that the supported hashing algorithms reported by the NIC are correct.
>
> Signed-off-by: Alex Chapman <alex.chapman@arm.com>
> Signed-off-by: Thomas Wilks <thomas.wilks@arm.com>

It was brought up at the DTS meeting yesterday that this suite is
reliable on Intel NICs, but unreliable on Mellanox (CX6), which I can
confirm after running on a CX5 and Intel XL710 and seeing the same
behavior.

Reviewed-by: Dean Marx <dmarx@iol.unh.edu>
Tested-by: Dean Marx <dmarx@iol.unh.edu>
