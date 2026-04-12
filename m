Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A7EE937EA
	for <dpdk-dev@archiver.kernel.org>; Sun, 12 Apr 2026 16:22:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0F7754025A;
	Sun, 12 Apr 2026 18:22:53 +0200 (CEST)
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com
 [209.85.210.52]) by mails.dpdk.org (Postfix) with ESMTP id 3ACD240150
 for <dev@dpdk.org>; Sun, 12 Apr 2026 18:22:52 +0200 (CEST)
Received: by mail-ot1-f52.google.com with SMTP id
 46e09a7af769-7dbcf927395so2125909a34.0
 for <dev@dpdk.org>; Sun, 12 Apr 2026 09:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776010971;
 x=1776615771; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i+1Zjk3vYKtoIg/3SGQD6m2ZAAYFrs4wJncDyFSxRas=;
 b=iEhqaJXcm0B54LgOsRW07QtLvMvbks2EoSOUaBdkDKzTrbK9vgW0LuhDz7yZGOl3fT
 78pvA55EzSIX7avTv3ahWuiPBRPBgV1RXmHsH7dpHBaQvcLOiZzw8uT3i8bTcO57CkMr
 iqY0K9ETRFIBAlWazosrzbAWY73WC5BlDlQr11ZVnn9/l6va2fDdV8Uc5ttdiw9dhX3Y
 akQqT+uiS4qDSA/eb96qJZ8v7UXMsasXP2iuAjtsJQXYr2nhJ3TXel1w3vankmGg12uJ
 OVz2pLYguU/WE3tePl7G4U+rteVoLV5TZZqTrhiLE3l5z6PR2PB1jv9Q8qLjz3+AWk+H
 giMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776010971; x=1776615771;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=i+1Zjk3vYKtoIg/3SGQD6m2ZAAYFrs4wJncDyFSxRas=;
 b=cbXpyuwyHc9hSctjziQFh7fT+bNhe6gXSgvCWjJWe+fCZBCDrUVcoqROz7nia1QlBn
 JVuu8OmXn1zbupE3U3/zyY0nW4Mk4wRhZIG+54qUD9rZ1KxyywARQsmXvDLkBkFJFTMq
 3a1qpYD1UoFI5bNUpn8lRP1jUvFP9fapNerUPe9Jk6Ku7zv3FzQKHKFROrjOs+1sd2Tk
 Ysjf7r+EF6+Y3G3zkOaJUX93ZRd9P5+ih4AMVAf/wBdvpSHfUaVNcyAYXT56EvQEIewX
 1+CQqfDYlD+txTohXnmp2QXxPajJ8myHw02TqxzouerZEVFhsIJJjMmjbfeV1Z1BdFsZ
 PDkw==
X-Gm-Message-State: AOJu0YzcLsqbEDLX/V0u8gzm9nqaYmE7nT3C5i+/MeqeHaLQ3TMQ4Yuu
 FjFtdpLeY3rlW/dBQnUxs3NuPHqZJIqq/KB9EMQcJMn24sCP0qxcmfQrqTE5y/fU0FuxcmC+Ous
 l2xgd
X-Gm-Gg: AeBDieuSgCSGEiery836WfnpJyd9u/Wdtfi5RncoX4jNfigdMv0cjlSyMDe6YqIJn6V
 MFfsyRiCtkOWsbvyCSBqJQsQkEbZ/nJ5infsAU3jILIJAvt3vfKgoFdAlq6dkJrMSULqXQR0xZX
 iE5jFKVFVYG/gMUeY0Da9gCZazoqfmbwVfsANWUWfun/H6jiUbt/II7/X6zvIpYqLyKwOxC1Uqe
 +6qHaShE9Dtlg8cjyOBmFTFCeeFy7ft4Nq2H4VlZbBO0+t+4FstKSs2/9akcn9IkyzD4sNi5JXt
 A67vQ5n0VKJlRZhqoQZB7grJKxPMGrD7anEtA7KFlk8s9KN4bU16AVV+NC3t7hqzOyCkdnlxG4C
 XJEqvX/CLjbyYHmzt6wzpf09n7EmiF761GJju7mYepmF2Wp9uE6G+aFFRj5iUwBTIe98wNVzuw+
 V1KxScdbySQyPaf4cdtyKosXBOjgUBVC4q0xY=
X-Received: by 2002:a05:6820:328c:b0:67c:28b0:41e3 with SMTP id
 006d021491bc7-68be8dd1293mr3353260eaf.57.1776010971347; 
 Sun, 12 Apr 2026 09:22:51 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-68bc7dfd5f1sm4293244eaf.1.2026.04.12.09.22.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Apr 2026 09:22:50 -0700 (PDT)
Date: Sun, 12 Apr 2026 09:22:48 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Junlong Wang <wang.junlong1@zte.com.cn>, Lijie Shan <shan.lijie@zte.com.cn>
Subject: Re: [PATCH 3/4] net/zxdh: remove unnecessary null check
Message-ID: <20260412092248.295f72f4@phoenix.local>
In-Reply-To: <20260401164108.201404-4-stephen@networkplumber.org>
References: <20260401164108.201404-1-stephen@networkplumber.org>
 <20260401164108.201404-4-stephen@networkplumber.org>
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

On Wed,  1 Apr 2026 09:40:24 -0700
Stephen Hemminger <stephen@networkplumber.org> wrote:

> No need to check for null before calling free.
> Found by coccinelle script null_free.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---

Trivial, applied to next-net
