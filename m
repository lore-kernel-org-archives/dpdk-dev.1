Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F95CCD1AB
	for <dpdk-dev@archiver.kernel.org>; Wed, 22 Oct 2025 16:00:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BC8E94027D;
	Wed, 22 Oct 2025 18:00:08 +0200 (CEST)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by mails.dpdk.org (Postfix) with ESMTP id B01F24025E
 for <dev@dpdk.org>; Wed, 22 Oct 2025 18:00:07 +0200 (CEST)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2897522a1dfso71682515ad.1
 for <dev@dpdk.org>; Wed, 22 Oct 2025 09:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761148807;
 x=1761753607; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=odpCw2madKLP2d0991ynCT2TZkwH6EISQ1BKCzsMhc8=;
 b=YQDBM4QnlqVkwtvPPeZ/0S1tMFDwOGXh8w1lbxP270MHFUYSnmBfedhvyTbMSPLVeU
 WdDzzS/3sqTqnypsGxPBTiFNAGWtEJgH9SlJNIpToklu2XWZzL36ywDr+wGTJzYdlPSU
 vE2Z8aBDRYSUuhAk1Mm133Hlu6K9IFUG4F89Om3Dbz0+xLaJP0c7zv5AzUdqfTcdPGRN
 LE8aLTs8zDWPxeL2/EKWDSK5GW/njlyXY0qq4eC4/5y3/PQUjurndl7d++F857Iz9N4r
 RMZTGC62Vav4CrUpExd96oPXD4Ltn2UMBf3bWGiB0BSaWPcpwx1D80iTbKB9peyLZHlJ
 R2GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761148807; x=1761753607;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=odpCw2madKLP2d0991ynCT2TZkwH6EISQ1BKCzsMhc8=;
 b=SIm6pVa+f4QWaDTPHfzto8xJYJO7FgFCKEzaH7QnmSUNecQu8RD+/eEoplnq7Ch+U2
 g/+cIGQsytU1dTNHttVnS4IggLC6o4oB8h/RnjIboGmenlFfZ+AOEUOnKMXJM6RMApEh
 nUG/XKe43WptrhZjHOqUrX9q70KqLGUzZFP5OeFv6qi7gFSZWXaQx4oOBxB9BbYKLRHY
 LGsgchmB93Sk1DYVp7NccJvlz2GgTjAG7ovOL+5UaXqmHZKCm+rp+VP4G1Bvn/Ew9Bl5
 wSzHQ7Of2KMYmuctWVM8P29oovHUaaZ5dJ0pY7zSFzv+gvB4w1vGyMkA+m3jEzXi2Zgx
 0D4Q==
X-Gm-Message-State: AOJu0YzxjqizmbG5D9EPo1xDReC0w8ulleu9aOQRKThEMMRwGkSW/Eh/
 hpbTx9Lp8rPXoUb0WTuAO+vC/LHeLp5/ljKMxXjAj83qHUrsI6bb6G43iH8QSazJ1/Q20T50G4K
 KGkR5f+4=
X-Gm-Gg: ASbGncvtlqarmXOI85ylcdQcvNnPbLgZYtr8s/OwhEV1V+5+6pQy6pbq42j1roV/yo0
 pV2f4Ezu1mXkvtrgVrsqcTA1/EUue+3tgTK1rTqeFJKLudpR/xR/Y+zYokyQMkJPsRl45cMFhxn
 b0I95AqfX95B5abBHSC4dpsvi5SZWj7cikAEY/H+kMkUIu5/s5y+rVel72DmxfRE6CnCpWgiqix
 HqE2E/KoDLZhWtPU6fP8PkED1GJC1qzpiwZkZMgyqENmXEHAloI2l49Hly6Dsp2nPke7DW/j4Gy
 YYtWZAlaOkv+3+K1ZLznU7HInUVm8ei4dL4HN8QjlZBbm38eNtcukcLxpwu+GJ9eMn6mOntWlZG
 JSRYiyE8m+0hAeKI+nEyWLZiR02W55EeseSTVQ5JmBGXZJH46b5EQwmpGi20EgU8B5sKLq6SkyG
 13SpS+E9gtYTxjaSOub9VSZzgXNjvTnya/TGm6uGHkjWTcHaBO3A==
X-Google-Smtp-Source: AGHT+IFz3uGe8V54qdGm2ZoFzI1ChtYLCSSyVFTiJj0OFG3q5Mgj82hvxi2XTo4Z/Z6ElaacDR83eA==
X-Received: by 2002:a17:903:181:b0:271:479d:3dcb with SMTP id
 d9443c01a7336-290c9c8a75amr255839965ad.6.1761148806763; 
 Wed, 22 Oct 2025 09:00:06 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29246fcc78asm143321155ad.32.2025.10.22.09.00.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 09:00:06 -0700 (PDT)
Date: Wed, 22 Oct 2025 09:00:04 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: david.marchand@redhat.com
Subject: Re: [PATCH] devtools: fix awk regular expression
Message-ID: <20251022090004.049fd27f@phoenix.lan>
In-Reply-To: <20251019160511.18173-1-stephen@networkplumber.org>
References: <20251019160511.18173-1-stephen@networkplumber.org>
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

On Sun, 19 Oct 2025 09:05:11 -0700
Stephen Hemminger <stephen@networkplumber.org> wrote:

> The latest version of awk (in Debian testing) will give a warning
> about invalid regular expression error.
> 
> 	awk: line 6: regular expression compile failed (syntax error ^* or ^+)
> 	^+++ b/
> 
> Fix by using additional backslash escape.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

This bug is impacting running checkpatch on next-net staging
