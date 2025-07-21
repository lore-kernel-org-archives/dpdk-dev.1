Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC67C83F1A
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Jul 2025 15:25:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7AD15406FF;
	Mon, 21 Jul 2025 17:25:30 +0200 (CEST)
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com
 [209.85.219.50]) by mails.dpdk.org (Postfix) with ESMTP id 1455E4069D
 for <dev@dpdk.org>; Mon, 21 Jul 2025 17:25:29 +0200 (CEST)
Received: by mail-qv1-f50.google.com with SMTP id
 6a1803df08f44-700c7e4c048so72134256d6.3
 for <dev@dpdk.org>; Mon, 21 Jul 2025 08:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1753111528;
 x=1753716328; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mMNUGG9tfOBpddlm1MFToN6Zkfriz3rnGCTF5G4yyJM=;
 b=jx1vgundcu7ZS+kH6Kqhgx37vbNBXpm2Oaw8IUjZD/jg3KufjeJFBvNd9oNz1jfTLd
 US1WY2ZY7KAGqIg07sEfbsQGx0uefKkkB2Or/tPZlWvQzrbdaATLSZFyQvH5/mrTRFIV
 ddGZXJ6ppfuizCok0btAAEbScW7hNHUGUPExNg7vcM1fghicJ4iBUMLfMCZ9461D16OM
 Blbe4apIE6v++GYB8RaCdExxt4fLU0PQ48t1TopFbesDJdkBmh9ar9/dmk90Y7vweYr7
 tkqQWN01kq7MypvB3uLO7oqkfzozCo7HaD4MMcwCTxuMt1zQ/TGBz+Y+IPiDggHZEytl
 w95A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753111528; x=1753716328;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mMNUGG9tfOBpddlm1MFToN6Zkfriz3rnGCTF5G4yyJM=;
 b=dwMjB9SK5n3BcRgi30pbjutfEI5kuZ1580A3MyYJxyXCOvlmaaF4z9D/lZ2VMn3KTN
 Cx1G51hdSbE9czLcQeCChCYMWDMdjjIf4LHH1wB6EiT6c+ohBr5tqYsVy/EBJkWPtmWI
 CvJKhCug5hvUAMg/UUEbjxPktfO/GX6e0OmvbANRQrVIbG8iPd42PzBUXXf41qKg3eIn
 KslBI6VItEj1hiWS/HIvVxjREXzg6Oy43anMpeoRVYHpoQp8kejHH9IXN4jXnDNIfj5H
 SJtw90szNoB944ELGKjunHBAjGvUwNUH8N0ApyLdcTpE/mi/kzJhSuq/8+vaXGSARkCC
 ZkIg==
X-Gm-Message-State: AOJu0YwBZc/ue3h+F4z/+VnC5VcsO62q+16xPMuB/HbRKusluSrQBgIj
 rft4M2mjfU+BS1qqXCLnDPwvE04UXA0ll8jfbqdYangFJdaVTloRSO26/rPN9xbB5YFSMybmPAB
 extle
X-Gm-Gg: ASbGncty/AfMflZ5a3Xzhs3def3ptaoAVwna0gZO6/ycorIHkr9PywSbzRkcMWJ5Hgb
 SkfMTulaPEYNTcFOI3hUQ5fJT4edPSRlu4CUJ0GF1jDyuhpjbyLydw/b27xXGL1Qt6xGQNjexKV
 SZ5YQpHek+WGnosaBjmqoDYJO7+FE6jtDs9J1Kd2qlUUHopOUkGcoEtPzKaM/Xl+f1i2Q0RBne5
 ZgbzW8ZdX5zzB061JJsbVV/SMIK9ydZ19SVwKdOST7cyf4jBNTdS3bzBwopaQNjxmdhPWgVBlQT
 etEnaHZ9SeMY0wBiduUcY9DDSSx8IqP2VoFFBJsA7k27u5lpQ0XTd2L5e85S8OfVr423Lc7FycP
 3jOSTpn+jlBnCJRb6My8dO7ZlM8V3xG9YZXhvfhQUeMmFmfhJtwn6PHql4nuCQYPVBOcdQs0S1d
 Y=
X-Google-Smtp-Source: AGHT+IHmFphTo/hdcdf+G6k8lTWrJyoYxbnN0S8hotFqrI1bnBB8ThWH/cYJfZCCQJJulMjYaucsLg==
X-Received: by 2002:a05:6214:27e8:b0:702:bd34:75c8 with SMTP id
 6a1803df08f44-70519fc9d34mr211188296d6.5.1753111528278; 
 Mon, 21 Jul 2025 08:25:28 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-7051b8bc22bsm40421696d6.22.2025.07.21.08.25.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jul 2025 08:25:28 -0700 (PDT)
Date: Mon, 21 Jul 2025 08:25:25 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jie Liu <liujie5@linkdatatechnology.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v10 14/14] net/sxe: add Solve compilation problems.
Message-ID: <20250721082525.286ab389@hermes.local>
In-Reply-To: <20250719090537.699357-14-liujie5@linkdatatechnology.com>
References: <20250716082930.83026-14-liujie5@linkdatatechnology.com>
 <20250719090537.699357-1-liujie5@linkdatatechnology.com>
 <20250719090537.699357-14-liujie5@linkdatatechnology.com>
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

On Sat, 19 Jul 2025 17:05:37 +0800
Jie Liu <liujie5@linkdatatechnology.com> wrote:

> Add Fix compiling issues.
> 
> Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
> ---

Please incorporate review feedback in new versions.

I and others gave the feedback that this patch should be combined
in with the patches that were problematic. Rather than one fix up patch at the
end.
