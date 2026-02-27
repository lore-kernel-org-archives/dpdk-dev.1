Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52ED71039882
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Feb 2026 19:43:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8A60D402EB;
	Fri, 27 Feb 2026 20:43:45 +0100 (CET)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com
 [209.85.218.54]) by mails.dpdk.org (Postfix) with ESMTP id 00274402E7
 for <dev@dpdk.org>; Fri, 27 Feb 2026 20:43:43 +0100 (CET)
Received: by mail-ej1-f54.google.com with SMTP id
 a640c23a62f3a-b936b85cc71so237882966b.2
 for <dev@dpdk.org>; Fri, 27 Feb 2026 11:43:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772221423; cv=none;
 d=google.com; s=arc-20240605;
 b=ZFcrw4b0cJaeezSbFSIE43WSO8UnNIn9Gdnd2moZc9Uzb7xuklPVdMqLCnr75fNtJ8
 kCuersc1+fMX1hNPlAsc+84VIK3fJ76cD4btKfskn4LVIxlry0CS9RrLmOrswyBeYyxU
 ylEXTu6pGHx4eumOHsaB3AaxTREXD0LLDl+v1oT0OZdshuj+PrcB8P/iaZUnNBOfbdzg
 AC0YZNDTSNFXDXLyKJEU5l7nJFZOx1Si4NcP8y7GLuDC1hDaZeKG8wFyh1Y65l/3l49L
 umK8eokO5jF0Uw8E0FOYAKYk1B+bUJfeimyKT0RKhIXcDYnds/OkYJP+69ADDQcxntdG
 UaQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=d6gzdMuatU2NHTclvPuiNyoH5JASyw4YzUpVEuqKwS4=;
 fh=E1XdLKO8dz+mVs+GGcAzOo4kbLqfI1uxe4mdIzo3ujo=;
 b=buYEUfyo+3FwBxTJ9CpTBnGJ8CkxGIohPqSnPOAm1I6nSkkB9HZFnsfmVqWJgfV4MZ
 COIx/RP1HBUcx/19917IURP2cghvmb1bg+gCZlt8lQ9LEn7wjAIt7jpmgVuIlEMW0yzO
 LODFdOUryWlcjXoesqVrLqtJovxm82niqybBrBZskEbMnFZdXnlIY9FZ9kPgxqTcWE7x
 PVidtjnsfP9utHYVRsN+ea8GF7n1rLzE5LiABmKHw32ouR8DImQZUiCDneIfiIqBHefE
 +3OpAVjyXQ4a3iMqcJfvsKEphdUMNtWtCBND7GELR1VEao1GmYNY0XZP4uICPkUyMiBq
 AIPg==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1772221423; x=1772826223; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=d6gzdMuatU2NHTclvPuiNyoH5JASyw4YzUpVEuqKwS4=;
 b=iE+jBmTNCFEiM4DPC7EUIJF2nOTl+53+0yVtaq4PU9NaFaHvD6/oXFB8CiFn4EtfbY
 +g2C7KHZwKXVDfD+1KH8s26Yrd4ZUf1/XibuxpE418TDmIRrAvkLs3ahZS/gdLbL8kTN
 Z7xzJsGd8DhQ3DpcwWY5g1G8PmqdzPIWgq2Zk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772221423; x=1772826223;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d6gzdMuatU2NHTclvPuiNyoH5JASyw4YzUpVEuqKwS4=;
 b=wDp92lVdPeExew8BxHEc36H9kp/SlFMZlnrpOUQptK/x4hNGTHKEPmWOQNN6GPN7sd
 zUwctvQnNIu9M5jkng0hAta9ecK164o345ShO0NMqkFyXNDH2ZkaVKUvEuvch0xcEYKF
 kceijIggGiN7ofUDAEBZ3fKURKmsIlgoMulDT2hHGxe3SJcGhOQGoFrIjzGovvEcf84K
 x/lVPerhk+frFEP98R2TUMfD+wMMnXZyxJkpxzG6mI16j0iRcnJ0pgDLREWZYijO8lkm
 H/fRmPrxEUykaNLMATdpLvU3nQ0vysYzGUFN5kn8lD9ZtmcloxPbwuFTVwWxhOLWYCha
 2dFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYGhV1unUV3deZ71sVJ3zoGKtrqYUYl4cK/19aL0WES+XKdmRspJPhyiV5OXeTXb0XJIQ=@dpdk.org
X-Gm-Message-State: AOJu0YxKZhPLrt4imlbRMQ8RXI+7u3mvUSZN2Y5ZI7R5PgdfMWWVKtzo
 8Vzq3VMwPlky+C4Qhj/1H8qTjQAWkB6bdFJlE5UnFiqLIwmNXuvH7IJVPy2hMduUnhCyxGdiDK7
 VySXvLqnHI56VM8WE6IVdBNqFjrKgpn3slvFXNYRZEw==
X-Gm-Gg: ATEYQzwcVWK+Tp12H+0Fyb875WkHZc7r8gEM1PbovXM7xgOvgjrTMy92m6xlnFP9uK+
 QuEAZ6sXkPw/nsAT1wv9GNX4DL9PwJGGYZHhS+J3H4gSy5mqDwNoKgN4aqLd5eQAHz8Gted6i9A
 eg8trAfz42dU9aDrrVA3l40r2SuF9PAf5ezhUmpa+kNHjSAGVfNDvLqz4R/AD4dNH4r3XBvkrAA
 GknAtdvyed514IDow24JFeP8DPcmY3Dwignyu2qcw5xXruQnUQde0CreyMe4hL2JIvBgpx7f5xB
 ux2oX62vRR7I1i/HIYb/FUp1SnaSsyrzg7PaRRKQ
X-Received: by 2002:a17:907:7b8b:b0:b93:46a8:3f3d with SMTP id
 a640c23a62f3a-b9376528b8fmr257820666b.44.1772221423521; Fri, 27 Feb 2026
 11:43:43 -0800 (PST)
MIME-Version: 1.0
References: <20260210193448.69423-1-abailey@iol.unh.edu>
 <20260213193539.103858-1-abailey@iol.unh.edu>
 <20260213193539.103858-4-abailey@iol.unh.edu>
 <CAJvnSUBJVSz6ZPuHuSmN9gyDBqwf_h6pcsJvnQg_9CfsnBNH=w@mail.gmail.com>
In-Reply-To: <CAJvnSUBJVSz6ZPuHuSmN9gyDBqwf_h6pcsJvnQg_9CfsnBNH=w@mail.gmail.com>
From: Andrew Bailey <abailey@iol.unh.edu>
Date: Fri, 27 Feb 2026 14:43:32 -0500
X-Gm-Features: AaiRm500C_mVqsDj4okiLGsF7I4flI0IMIUJoXFHxERKDfrYOPquOub9eJexN7U
Message-ID: <CABJ3N2VWp24usKU2J=t2y5eL=ZT8T40ZNtu0yWRt_TROmhHP4Q@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] dts: add cryptodev throughput test suite
To: Patrick Robb <probb@iol.unh.edu>
Cc: luca.vizzarro@arm.com, dmarx@iol.unh.edu, dev@dpdk.org
Content-Type: multipart/alternative; boundary="00000000000069a197064bd374ab"
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

--00000000000069a197064bd374ab
Content-Type: text/plain; charset="UTF-8"

>
> I noticed that for the VF creation, the crypto interface is being read
> 3x. Are there 1-2 additional checks happening, or are we just hitting
> these code paths multiple times for good reason? Maybe not, I'm just
> checking if there are any inadvertent calls. I guess this is a matter
> for the 2/5 patch though:
>
> 2026/02/26 04:44:46 - test_run_setup - dts.SUT 1 - INFO - Sending:
> 'sudo -- sh -c 'cat /sys/bus/pci/devices/0000\:76\:00.0/sriov_numvfs''
> 2026/02/26 04:44:46 - test_run_setup - dts.SUT 1 - INFO - Sending:
> 'sudo -- sh -c 'cat /sys/bus/pci/devices/0000\:76\:00.0/sriov_numvfs''
> 2026/02/26 04:44:47 - test_run_setup - dts.SUT 1 - INFO - Sending:
> 'sudo -- sh -c 'cat /sys/bus/pci/devices/0000\:76\:00.0/sriov_numvfs''
>
> This is not normal and will be fixed in v4.

--00000000000069a197064bd374ab
Content-Type: text/html; charset="UTF-8"

<div dir="ltr"><div dir="ltr"><br></div><div class="gmail_quote gmail_quote_container"><blockquote class="gmail_quote" style="margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
I noticed that for the VF creation, the crypto interface is being read<br>
3x. Are there 1-2 additional checks happening, or are we just hitting<br>
these code paths multiple times for good reason? Maybe not, I&#39;m just<br>
checking if there are any inadvertent calls. I guess this is a matter<br>
for the 2/5 patch though:<br>
<br>
2026/02/26 04:44:46 - test_run_setup - dts.SUT 1 - INFO - Sending:<br>
&#39;sudo -- sh -c &#39;cat /sys/bus/pci/devices/0000\:76\:00.0/sriov_numvfs&#39;&#39;<br>
2026/02/26 04:44:46 - test_run_setup - dts.SUT 1 - INFO - Sending:<br>
&#39;sudo -- sh -c &#39;cat /sys/bus/pci/devices/0000\:76\:00.0/sriov_numvfs&#39;&#39;<br>
2026/02/26 04:44:47 - test_run_setup - dts.SUT 1 - INFO - Sending:<br>
&#39;sudo -- sh -c &#39;cat /sys/bus/pci/devices/0000\:76\:00.0/sriov_numvfs&#39;&#39;<br><br></blockquote><div>This is not normal and will be fixed in v4.</div></div></div>

--00000000000069a197064bd374ab--
