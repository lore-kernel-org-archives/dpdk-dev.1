Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E22C43458
	for <dpdk-dev@archiver.kernel.org>; Sat,  4 Jul 2026 16:00:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E9BA8402C6;
	Sat,  4 Jul 2026 18:00:54 +0200 (CEST)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54]) by mails.dpdk.org (Postfix) with ESMTP id 3888F4021F
 for <dev@dpdk.org>; Sat,  4 Jul 2026 18:00:54 +0200 (CEST)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-37de8008910so1473685a91.0
 for <dev@dpdk.org>; Sat, 04 Jul 2026 09:00:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783180853; cv=none;
 d=google.com; s=arc-20260327;
 b=VBKwsCaZJWGPuAIIG/ib+PsG4MRAAma/7r/hZv3bAvOiIXPHKtonSYNcPIubxYTD23
 J6r27FNmCLEDdst+zuR69asAn8aaGMNX8Oo2L/30fD1EaFR0dwiLFqCvDkrfIdUy/poH
 mkzWVEFTFcdAYCRiUrPtNr+0H7gCgNWLroZT6LGYY9pm8KBrDK8+P3zb/KDEVYmtQeuU
 yfofqqyByUxPi+r93V861xPb+PDmONcxJXnmGL8M2vKH/JCa1CfVqCyxCVtm6Fmji+AY
 1CtYRIvcfA3u0BSFA7sh9uKxVB+tWtjGuO0axTUELUwHDhWlKwqX9hTStbAUJJUUTQ6B
 +w9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=SkGnBPfSEPwkOIXH2GeVrAXkaiseTAGpeQahhKBagZA=;
 fh=UdXex26VCCvvoELUqmMgxHjApJ8GzQWl0b4BjnWQTl4=;
 b=hfr2d0tCEuvASwT3sWOchu77ijWVwe0GmoFytPaCL4SITUVW8q3xAH3SxaxM3/axOC
 dW8ASO+MdO6p28QHFwYdcS77LPJS4yZ63vhGqZJFXAv4ugAceo6W6RbCE89oYVECU/VO
 iIqw7Sz5KZrIxAEcMOxtAXXbsT6Ku4sbVVooY1VwIjVzqmWPuG8JXbRWTGWNzIIwF1dg
 Ead09F76Lf89seQtBSWEx4v6PWx3TrgU+7eX7dtuRLt0uwOVFm0eegj5dxAlkjt445mI
 wv2R2iI4+iYUqON77Kezhp9X0j+eFYGoGc0/txMcpRdakXDb1UQ9+lUNbU7iJf8O7KRN
 VKgg==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783180853; x=1783785653; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=SkGnBPfSEPwkOIXH2GeVrAXkaiseTAGpeQahhKBagZA=;
 b=k6vgemrMKKQWKClXMdgUXBJJCoqGNGRPEYOLA0mrjidTCWzACxKVtAEt78B5xL1QDc
 2pccLw7xDf0Ym0Fu4mhPwZcA850ELmKo4FR8qjuZoM0DvcyDtEKtLhpfUe2eG3AEp3ag
 se+p7GINH1MD4YpHJxI9bDgaTHQ1j6+PQ4tU3AN+0w/webjCS7tJUlhrZUvsxkL7Uwp+
 /TiAJ8we15Kn/HHrP57KvC1CtbHpuZaH9FnqMnr9G/oh9nYcdUU5k6KXIpRTJCbY13aH
 SkJtBwWMJdw9qQIsW6PxPtgtiWSOwHHqBNjj+FwfhNu9SlAqfjDjwXNOddjC60LJqITo
 EKWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783180853; x=1783785653;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SkGnBPfSEPwkOIXH2GeVrAXkaiseTAGpeQahhKBagZA=;
 b=HU0SAxjuqzCP/uA7+0SpDhEbI+ocsmziCM05PiEdfP1/zHlBZshVQJTvCGepD3iek3
 D0k3DR1u4IpekzttDuUn5EW9ttQzQ4acxqXJAHijnmqXE53yi+hmsdDZ78/qV376XZeP
 f+gyeEzqHbLWYuRRaIDTKAClbYwCUJGEIo2hFoi1AVHrVaTuDp+FrFVS+e1AvKhmOINv
 ISNDCWF3CMkFgk5NsPkqMB+Gp/wuXXFiIbWtQWTrgVu2SVZG6twUTj9RQa4sSe/jtVMs
 Iv/3hYmVYOJfpMLXYLNFZvVhIdS3TQFpZEuwClgVVoq059YEgY6hNU2Z1W5IJ7QWtq31
 64KA==
X-Gm-Message-State: AOJu0YzqN+FflliMUuVhcF/hBboIJmttaTSheCC64xcVUBPW8YL+zxPP
 oXG8tD/h5i+IDcGzcuI8cDQo0mCAc5MA6KcZXoW7XNsXo2VXidRP+FwTaop245vHeFbkRUgxhgN
 Wd3HzEPVXx9cvBIqjWI2AX8wXCa05YnJQYt38
X-Gm-Gg: AfdE7ck/Xv8S/QN5ODdLDx0a/y+hlcNfSlc664imwVqMTW0YkhDJM2KI/RPDgQwCit0
 M1ow9L0FrN+JohQ2Fr/gpjRp84pB7+BAEIc7u6/ZaWf5uBVk/xmPqgmN+47ldd5KXMD+gfX5ZUB
 NGcUZp3sYGa1dn52F7YkfysdyGt0e8SFAvv/eqtQJ8/gqCWFR3o43dS46HMbnioujg+RW9oQojj
 4PzRVIkmGjI5MR1d2RYWeUFzsAJXNspaUput2OgFtzaR98J6VOW+jLJoSE/jvdzda9ib8ql
X-Received: by 2002:a17:90b:4ace:b0:37c:6130:7a5b with SMTP id
 98e67ed59e1d1-38280d99a9dmr4242718a91.8.1783180852923; Sat, 04 Jul 2026
 09:00:52 -0700 (PDT)
MIME-Version: 1.0
From: Weijun Pan <wpan3636@gmail.com>
Date: Sat, 4 Jul 2026 11:00:42 -0500
X-Gm-Features: AVVi8Ce3IrKNHGi_123slH5gb4Yt9kH-_HYqgOr3R5loyh00TzTREFdn_nWDl90
Message-ID: <CAMEmXsxzEfsu1boqPrYtTbuf3j9VM0vb8JBzC-NKm4YXJFVPNw@mail.gmail.com>
Subject: [RFC] net/bonding: support limited datapath in secondary process
To: dev@dpdk.org
Cc: chas3@att.com, humin29@huawei.com, stephen@networkplumber.org
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

Hi,

I am looking into Bugzilla 1900 and real secondary-process datapath
support for the bonding PMD.

The current secondary attach path is safe by default: secondary Rx/Tx
uses blackhole burst functions instead of installing real per-mode
bonding burst functions. This avoids crashes because the internal
bonding state is not valid in the secondary process.

However, this also means that a secondary process cannot perform real
Rx/Tx through a bonding device. This is the issue described in
Bugzilla 1900.

I would like to discuss whether a limited secondary datapath model
would be acceptable, without fully sharing all bonding state across
processes.

The proposed model is:

* the primary process owns the bonding control plane;
* the primary process owns the LACP state machine for mode 4 / 802.3ad;
* secondary processes cannot change bond mode, add/remove members, or
enable/disable dedicated LACP queues;
* the primary process publishes only a minimal shared datapath state snapshot;
* secondary processes only read this shared state for Rx/Tx decisions;
* blackhole burst functions remain the fallback when real secondary
datapath support is not available.

For mode 4, the shared snapshot could initially include only the state
required by the datapath, such as the active member list and
per-member collecting/distributing state.

This would make the secondary process a datapath consumer of
primary-maintained bonding state, rather than a second owner of the
bonding control plane.

Questions:

1. Should real secondary datapath support be considered at all, or
should bonding secondary support remain limited to safe blackhole
Rx/Tx?
2. If real secondary datapath support is considered, is this limited
secondary datapath model acceptable for the bonding PMD?

I would like to work on this if the direction sounds reasonable.

Thanks,
Weijun
