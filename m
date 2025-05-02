Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41846C3ABAA
	for <dpdk-dev@archiver.kernel.org>; Fri,  2 May 2025 15:51:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7979C402F0;
	Fri,  2 May 2025 17:51:27 +0200 (CEST)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by mails.dpdk.org (Postfix) with ESMTP id 78AA8402E6
 for <dev@dpdk.org>; Fri,  2 May 2025 17:51:25 +0200 (CEST)
Received: by mail-pf1-f177.google.com with SMTP id
 d2e1a72fcca58-739b3fe7ce8so2257252b3a.0
 for <dev@dpdk.org>; Fri, 02 May 2025 08:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1746201084;
 x=1746805884; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XQFYxwzPgVhx+jBwCUJy0IjDf9pvCxulJu9bpYK2oGY=;
 b=BPEppPU9ryGRMGGVr9vKyDsyLzmpTwtlvsfOrwqSsl63MDj9f9F95egxxW6iPc2IOr
 HrvSHfsk2N2XHHCGJqDNRiyNO7rXwZz7EJmRIxaxvluEAdQ/uTIA3+bR49GBWeSnX7ac
 WrCRMr7oniGb3iFwboelQKU3QTpW+6D5kHdaPvdCv8aYLkLn68YIN7lugR/S76S8ijg7
 rFiQ3C5Aj3k1+/PNPJ5KWJY8eCl2G6eRNRKBofpgg2HB7fqSdYIGTTAE4YTVrp7fFVyd
 3UTombOA3xuDQ01rWgyxtDWeWZzuIjwD/X1RF5YCuYg7yv7PqdzelJjrn/SpG1IZ13ID
 +yJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746201084; x=1746805884;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XQFYxwzPgVhx+jBwCUJy0IjDf9pvCxulJu9bpYK2oGY=;
 b=h7n0DDfmCaTpKn+3D5D//1pZydYJ0jV5h89Xk5oBRroJrAR1T/dARyDCXJQP7yGGvT
 gzn3P5hM13WQ+MTeR0DV0jM7qByR+LPar3XK6PBeQzP9eT4N1py/Z8g0G/D5RYxHUzQE
 QQYE9S6qaGDFCLPqeTW8yGaDha50Lt2XzySvzx2JFL2H5mqC+/M1Fh5qtiltc4sCLox8
 tf+qUTt0cukEyMn6hnW7TsW9dV+1f/nD9MBaj+8QlvQerkAnRO2TSzcQirV/5Ce9NZaL
 NkkZQesD1DHhF+ZnfiDW+6Lv0w6eVrRnN0nnkcgVsAIhchJr3+Yxkk3eeSL0kE2ZuNQ4
 nDXw==
X-Gm-Message-State: AOJu0YyIr/y3UakWI08kBD1cMr/Et5f0CUH6/ZfA1RoOXEhy7wfKDSk2
 1EhnFcxFc5hgVgSlmE5jTLuin5CT8lOvAJw9Q9KWz3oAIxh3ZBggvLf8xFDd5Pc=
X-Gm-Gg: ASbGncuRpwlEDWrSinl5+OAzvQ8zvWBUASnEBZ6YiAEFmbpOk17n/Un19sXB8ev6RAI
 7q0wfB+qZ/aNB504Hfai87V9n332tgBy4VXxEyJIFWtPGMY2RoEv1qPPZjwT9uuAaXEnUNePOWd
 H0X0GCgiX4dhADwI8TzZE0Q5/a8TO4kolVs9wOFA+godKz79VHDuWvZDN1henwspyuKtFO1W4Od
 fRIKWYDUAUQaZlpXmy5Gl4h3os8eWL6Wx7MOZTS2ae/qj8DbZyeFQz1qwd89QLhbs3BNj23vUmh
 +qQBbI3hJBKmmq4AyrNkHC+0EEuKrk1yhCGURp9QMx25jPttIv8BDkiMMkpRtCCLO/1hkhJizZz
 OFNRulaku5/94f+9/
X-Google-Smtp-Source: AGHT+IHmudXYE/ywF+kc7B6ETO3R4VejK6icQCLwaIr8wli0363BXsAm8sqzaibA4bIOZ4/6G7eWAg==
X-Received: by 2002:a05:6a00:338c:b0:740:4095:4d07 with SMTP id
 d2e1a72fcca58-74058a48d5fmr5127745b3a.12.1746201084536; 
 Fri, 02 May 2025 08:51:24 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74058dc4641sm1794686b3a.66.2025.05.02.08.51.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 08:51:24 -0700 (PDT)
Date: Fri, 2 May 2025 08:51:22 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, david.marchand@redhat.com, mb@smartsharesystems.com
Subject: Re: [PATCH v3 1/4] eal: deprecate old coremask-based EAL parameters
Message-ID: <20250502085122.2e9db643@hermes.local>
In-Reply-To: <20250502151134.536799-2-bruce.richardson@intel.com>
References: <20250313113829.1480907-1-bruce.richardson@intel.com>
 <20250502151134.536799-1-bruce.richardson@intel.com>
 <20250502151134.536799-2-bruce.richardson@intel.com>
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

On Fri,  2 May 2025 16:11:31 +0100
Bruce Richardson <bruce.richardson@intel.com> wrote:

> As the number of cores/cpus on platforms has increased over the years,
> the use of coremasks rather than core-lists for identifying DPDK cores
> has become more and more unwieldy. At this point, let's deprecate the
> coremask-based EAL parameters for future removal, and point users to the
> core-list based versions instead.
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

Agree.

There are some more syntax options on Linux kernel command line:
https://github.com/torvalds/linux/blob/master/Documentation/admin-guide/kernel-parameters.rst#cpu-lists

cpu lists
Some kernel parameters take a list of CPUs as a value, e.g. isolcpus, nohz_full, irqaffinity, rcu_nocbs. The format of this list is:

<cpu number>,...,<cpu number>
or

<cpu number>-<cpu number> (must be a positive range in ascending order)
or a mixture

<cpu number>,...,<cpu number>-<cpu number>

Note that for the special case of a range one can split the range into equal sized groups and for each group use some amount from the beginning of that group:

<cpu number>-<cpu number>:<used size>/<group size>
For example one can add to the command line following parameter:

isolcpus=1,2,10-20,100-2000:2/25
where the final item represents CPUs 100,101,125,126,150,151,...

The value "N" can be used to represent the numerically last CPU on the system, i.e "foo_cpus=16-N" would be equivalent to "16-31" on a 32 core system.

Keep in mind that "N" is dynamic, so if system changes cause the bitmap width to change, such as less cores in the CPU list, then N and any ranges using N will also change. Use the same on a small 4 core system, and "16-N" becomes "16-3" and now the same boot input will be flagged as invalid (start > end).

The special case-tolerant group name "all" has a meaning of selecting all CPUs, so that "nohz_full=all" is the equivalent of "nohz_full=0-N".

The semantics of "N" and "all" is supported on a level of bitmaps and holds for all users of bitmap_parselist().

