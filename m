Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB19FC72C4
	for <dpdk-dev@archiver.kernel.org>; Sun, 22 Mar 2026 16:41:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CEDD240647;
	Sun, 22 Mar 2026 17:41:30 +0100 (CET)
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by mails.dpdk.org (Postfix) with ESMTP id EA753402EE
 for <dev@dpdk.org>; Sun, 22 Mar 2026 17:41:29 +0100 (CET)
Received: by mail-pg1-f180.google.com with SMTP id
 41be03b00d2f7-c742bc88d87so1213301a12.1
 for <dev@dpdk.org>; Sun, 22 Mar 2026 09:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774197689;
 x=1774802489; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JzYO8rCFYfpLj3zaPVjYu2bPIdmnm9nWL9ldHNqiZbU=;
 b=uK8xeEFqsLjsJXtTxUHvQmUDZKT/R7qzhe++qJlfwTZACgFXW72FER4zz2Rzbtd/Wo
 7iIGRmkU9Zerl27Ka3DE3uLmUuaR2L1I7jCizk/NAm9SitZhBRypjKxDeyfn3C/x27lh
 HAgeMIVgzsyF+fk7cDpaT+qU5ttSVe4Zky60oqfRsufPFudZDF0n6tvmBxm3Fyip99MF
 GN2AoIN/jZfp+dJBfFSb02C79AxdmYjzJJ2fS8VB4XVhInjZssdJ8ksM7/ewEN1fZVSa
 it0SnD/pdsrwNvuLFocvCUqzMK0XT/sHImqJ4FDGiVh6u23d3VXCw6hoW0GJDL1zfcuV
 eN2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774197689; x=1774802489;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JzYO8rCFYfpLj3zaPVjYu2bPIdmnm9nWL9ldHNqiZbU=;
 b=gJcqXaKNHyhP2Odw9SssajigxMbxmnTwfyiCLnYLjJoaYaacIwamacDBbP8d09/xCu
 W/ycswqtAoMFnIJoqJGInCGk2pM3Giknz30dNV2bBATTxhy813nNxDBrwyYuzgwLfsvY
 p+9Jgb/JWCm3uDMqyCK+z25rUjG4iNej/pJK0z8Ol1V7brYG2PY46mWcQ9cddvKRsYrO
 uW1zIWq4nZguVUloO27aby0qOIN1UXgjHlH0tmoTmJoPalRCE7W0PBQEXonLHXEgNy/0
 yKH/c/z0g1GZp3BRw4g1D57N0mu1gssn9UFloNzX+vmaXx4p08GRYqc2XAYc3T1UEYAd
 ZdBw==
X-Gm-Message-State: AOJu0YxJRpUadk4iTH6o5qrNMaWBGikckxqUH312haq3o19+heSOy4ZR
 RvWZgyXRitab12gZh6E9UYO22dgDiMwp8W2bUjhUuDio3sfmW9H9uW2LP/tYmqGAAvw=
X-Gm-Gg: ATEYQzztfumniFclmi1On7kCrCQSH8gYix4kLkFtAbRf8HGYXBLvhrKmU0cSaxVxalD
 kueefdEgxS1+3oZc0UI4mnlJQibczSO6cuJ0zZTJc04LZiBa5I5zq7SCqit9Vcd83dp42dp0aAt
 q4t8QmTiWjEZfSWgzhFzaTPzJRqHcpEsdrvFoeHa4MaVuWIMDR4MoVSxYA+Q5G0m2DIH7dj8+ZS
 mqP9q9phfviFe0wz7EpaEh/xXdk3oUiLkxFNHywWZ9p9PcSrGSciqhO9yrD9o3Ac2JXemUZrKXm
 XbKYY3uYH4/MNh9uSdpdnhQ803qzdZma0M2Rv0l+95BKvSuORuD9IM5fMPy/5W52g2kJoKBrmzZ
 KcQs6y2Vn/a875oHdI9IWyRwaRcRQj2HBXGkY6sBZ0cloYmyNdpIzNmEuzvhHmoR3sMj2AwmJqW
 d0AdGlkodqfGwY29anoRou5LvGuy8vHIStK6Q=
X-Received: by 2002:a05:6a00:1483:b0:829:a3ed:9749 with SMTP id
 d2e1a72fcca58-82a8c388f72mr8348954b3a.57.1774197689038; 
 Sun, 22 Mar 2026 09:41:29 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82b04220d9asm6761870b3a.60.2026.03.22.09.41.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Mar 2026 09:41:28 -0700 (PDT)
Date: Sun, 22 Mar 2026 09:41:19 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Cc: dev@dpdk.org, rjarry@redhat.com, nsaxena16@gmail.com,
 mb@smartsharesystems.com, adwivedi@marvell.com, jerinjacobk@gmail.com
Subject: Re: [RFC PATCH 2/4] fib: add VRF functional and unit tests
Message-ID: <20260322094119.35230770@phoenix.local>
In-Reply-To: <20260322154215.3686528-3-vladimir.medvedkin@intel.com>
References: <20260322154215.3686528-1-vladimir.medvedkin@intel.com>
 <20260322154215.3686528-3-vladimir.medvedkin@intel.com>
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

On Sun, 22 Mar 2026 15:42:13 +0000
Vladimir Medvedkin <vladimir.medvedkin@intel.com> wrote:

> +		case 'V':
> +			errno = 0;
> +			config.nb_vrfs = strtoul(optarg, &endptr, 10);
> +			/* VRF IDs are uint16_t, max valid VRF is 65535 */
> +			if ((errno != 0) || (config.nb_vrfs == 0) ||
> +					(config.nb_vrfs > UINT16_MAX)) {
> +				print_usage();

Should also check endptr.  Right now "-V1xx" would be accepted.
