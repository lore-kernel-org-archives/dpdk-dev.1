Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1705D12689
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Dec 2025 23:49:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D038F402E2;
	Wed,  3 Dec 2025 00:49:16 +0100 (CET)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com
 [209.85.222.178])
 by mails.dpdk.org (Postfix) with ESMTP id 179D4400D5
 for <dev@dpdk.org>; Wed,  3 Dec 2025 00:49:16 +0100 (CET)
Received: by mail-qk1-f178.google.com with SMTP id
 af79cd13be357-8b28f983333so591867185a.3
 for <dev@dpdk.org>; Tue, 02 Dec 2025 15:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764719355;
 x=1765324155; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gLVTix3EQH9C4n+3z5DTCOHCl9dB8HKsus3idDkREHk=;
 b=esM5YZ6ljYu5neJf8Q00tbEWgS7wG6Lww4AWFvIVYGobWPAPwdOER605Ga9xoFHfUL
 Pe48WIyqOqMEDnMtTDTVoP3w+HLgXOcMwFyGBvv6KdDOObbgyo2Ggll/+/VNXR/jkEDY
 S0GQAYCIO/ZKMRGSN3+a6Eb4Ony6HHILioY/f892sg/8Z1a4vTMcvsPOJiORHpHdAdcp
 GMOtfRx/y+btZPwfUe9F4iPbSkS2CCMyE4MXuBgNuupz+M4ij2wLh11hcb1LziwojCoF
 ET7PCgcuUAUaNwVQP2Zr3uRuGyn98pI9VI+XU2T+ziSrqydr4DgUb8H5ndt3JmVEtuMu
 28tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764719355; x=1765324155;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gLVTix3EQH9C4n+3z5DTCOHCl9dB8HKsus3idDkREHk=;
 b=I/LrvfT1hgcSVGGeWlDQkvd5fj0OuRnzlGqEnn6UZV85kFtWg9bvN3ImsZ2lMnmQqZ
 r7EnlocvLrxvPteGrr5FInavhDSvusMeKrs+zIHDYn1DbwQqFgvhyLyyIZKf5ya9WzR8
 odD4o6Uuvmg7jZ54eDQwFsAhZcsa1WjFBYIPywA7jw0WD9suYYat/znQcaVvLuFhPsPU
 mNkwosF+toVFwV1JnCJxI4zcHXR65hNCxfosK077jNIMsWJqwVgqqTQDZIyl38LtFHva
 iSInlMXNKJTCXJwPN48FgmxtjYHM0zFr0gfVwtekkvBSEtExZAL+N6YBWAC7v7pzewlM
 ca5Q==
X-Gm-Message-State: AOJu0YxL2GvcfoAfYlekPbZ4FctmQeudmrAqd+cJnkW1WYY6e2KFqdZa
 bNvp6Rt9cY+jpCjpzSUGLkshTT2phYHMy/PPC8a1uyWuwgsgSjcDux4ayf0Up/FhOo0=
X-Gm-Gg: ASbGncun2/480Xl6YxAEE7WEuoMYGaC1aPhMWnc5by/Y3TWMoDI/9IxCPPmSvfxOoIn
 alpA3cy0FVR6ee22lQjoFlP1ivGXb3uOhIKkjuqqc41A2lhj+IYu57rFcSKdf5fyi3VtCr1d7n2
 swvFDM+ytskSnxW2um2jbXFFNh/oGlNLEwZb6OCXtQgS68mnWBKG2hCFC3oKMquJ4fdHJiG+QLB
 YoSRy9znL1AuUK3rw0v3+ITnOtYFkWSNoXWFXZHm3gOZvfP1tyfzSZLp1XVW87FU4Yy4st92vVx
 lzmMjgebUpzXV32RKpUb05C/iHYyg0MCAajBCTm+1mXlV+1Q+iE7Ak4WGH+Nc/GHVldSMpdVX8R
 67VkdhEZDFImAy2/ZSb0OpkY4ecqeuJ6yPl3w/FWrgXUX1O2fpTOy2BGVUcsrSJslnrbJ9TquJt
 ZPPD67mYbg/Kk81qeAGMHsXehcQg75e9+of5ORHxaS7smc4aNFTc7hYnBsWvUgU3A=
X-Google-Smtp-Source: AGHT+IFyFESdQ8YagY4IY7A+bShwFefYQ2L3dUgkmHP6mSIusuOLafn7wW6Fef7ztYVn7xALrIt8UA==
X-Received: by 2002:a05:620a:1788:b0:8b2:a0cd:90f1 with SMTP id
 af79cd13be357-8b5e6e856b3mr44790685a.61.1764719355388; 
 Tue, 02 Dec 2025 15:49:15 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b5304c960asm1101579785a.19.2025.12.02.15.49.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Dec 2025 15:49:15 -0800 (PST)
Date: Tue, 2 Dec 2025 15:49:11 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Anurag Mandal <anurag.mandal@intel.com>
Cc: dev@dpdk.org, bruce.richardson@intel.com, aman.deep.singh@intel.com,
 stable@dpdk.org
Subject: Re: [PATCH] app/testpmd: fix incorrect function names in logs
Message-ID: <20251202154911.7b1a377c@phoenix.local>
In-Reply-To: <20251201100837.422764-1-anurag.mandal@intel.com>
References: <20251201100837.422764-1-anurag.mandal@intel.com>
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

On Mon,  1 Dec 2025 10:08:36 +0000
Anurag Mandal <anurag.mandal@intel.com> wrote:

> VLAN extend and tpid setting functions have wrong function names
> mentioned in the error logs causing confusion as functions are
> not found in code using those names.
> 
> Replaced static names with dynamic "__func__" predefined identifier.
> 
> Fixes: 61a3b0e5e79f ("app/testpmd: send failure logs to stderr")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
> ---

Queued to next-net for 26.03
