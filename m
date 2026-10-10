Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2867CCA6017
	for <dpdk-dev@archiver.kernel.org>; Sat, 10 Oct 2026 18:32:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5F93340687;
	Sat, 10 Oct 2026 20:32:21 +0200 (CEST)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by mails.dpdk.org (Postfix) with ESMTP id D47F340687
 for <dev@dpdk.org>; Sat, 10 Oct 2026 20:32:19 +0200 (CEST)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2df8c28a0b1so3199585ad.1
 for <dev@dpdk.org>; Sat, 10 Oct 2026 11:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791657139;
 x=1792261939; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5RehjmjoWys+rN2es+UwNGQesYOLevQWpBoQrwDVHNY=;
 b=mwa+7w/vzjeClHs+Aj2iE2SearNYfc3lNbfxedo/f6wTfxcvyl6r1/mRK3P2FtmvO0
 zHdqXcgwHe26Ym85c1+8KbarPyxpUVVvGT2IzeJLffC7c7ScIFF2cgtVGCD1Yu5JYkbq
 lmlABLKNSi5rPK1lqKbWvB0z0dkrTILZuMn6adCHtK/W2/1hQX7K7+zevqP3x4N0GHXM
 Y/XzMJDW/PwFs7ttVDyNtbmWrkQ6x49Quh6OXW7etubMo/Un65IUYKCAiUFFVQFK1CpZ
 ton3cwEbONcxch8Yl4C63XDoJR2fzi8frJx51KWFtfWpUzlkCE5oUhx7uCfb2r1gEKxG
 QxGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791657139; x=1792261939;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5RehjmjoWys+rN2es+UwNGQesYOLevQWpBoQrwDVHNY=;
 b=0D2y/fTDIRDP6yruYtQHU8ZI3jxLY44Hz4sjZOJc9FQIzQMIDPUfAfu2ggKymgljO1
 5PCnK4OwC64mgc77MagMrAWFK63+gj33piNb0jGWK4qjuvpGlZUdhGJECT0m96hgYZrF
 x+rYTWnl+oIGFZh8hjEggwKEUrIyCi2RAhmzHWwrMo9iKSls3GTZv+Z6eNxDfLhDfygN
 QsumFXradhSrP2xJTKeUATfJ96/yVo92ksi7WlJxF2DndZ9Cy/qtjAxjhO8S1oUHRt4R
 CLgT/DY6O+IAvqTvuou911y4o6IV2UiyeytEyqV6skcC26Awom72tcpMY6Nf+HLn/E0A
 593g==
X-Gm-Message-State: AFq9FYJKMXWy6PIt1/fNau5faHYiJV+voauAulIhuMjWOX1wI+xafmj0
 yqpjlo3fH/lQNWTJ7zYswmlJd0i/M/iVvUbh6Rt65JCDRtbv/g3mYDKYfNPxxb3mJ24=
X-Gm-Gg: AYBFou3GifE5QMQ7oIwoYZcsdwmU1CR+HlWmFsOct7/B22lR2Ah1/qRESl9JsITZ7P3
 Mv2w/4khagmkkw5PLvnCMiGf//qCyp7jF1IuK6TqTMbPeqXABrvT5/u1YmRlBoK/dYequXJUJu/
 JvI1nIozRlmnDylY0tjvQ6kkbzM8Y8eFw87CPg+sHZXaPv8v3mJwFUMVodz2fMZApsQFYxwiT3z
 kOKd1e+18bqnaxU+1yWiCQ6YOH4fi6J86hrwOXfTdVvun+s/q1nHzEeOUSXTME3A5dJcc75zShi
 RF6AzDSa8spSZYXK5G9ZMvwujm4pA8CA3AYh0SHzol+j/DUA+ZpbTmCsQiKz5+p1mUMFoPwEQ4A
 KsgzgcZuhNdJTi4e26L5+zDopkGkkkHbgAQFytBMM8Dhqv0wHTms3zkQuwZTKYhz8C1jzEiudCU
 Ew4ZVpwi6uL8cSSpoLRqV5t8xotI5Mtb7LCRMGiS4pQATcvhs8WlYUEINKf1d7z1wrYTfvfmWYa
 RLiWybtW1ywD46M5EIplSO5YGVbRG543hcQE/hz
X-Received: by 2002:a17:902:ce91:b0:2df:90d4:7758 with SMTP id
 d9443c01a7336-2e8428a1f32mr42507385ad.23.1791657138816; 
 Sat, 10 Oct 2026 11:32:18 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e8419ff572sm24651035ad.2.2026.10.10.11.32.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2026 11:32:18 -0700 (PDT)
Date: Sat, 10 Oct 2026 11:23:18 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Roman Khromenok <roma55592@yandex.ru>
Cc: dev@dpdk.org
Subject: Re: [PATCH 1/2] ethdev: decode newer SFF compliance codes
Message-ID: <20261010112318.483bbdc9@phoenix.local>
In-Reply-To: <835d139c746faff456f14755b7af7395b713bd70.1791574390.git.roma55592@yandex.ru>
References: <835d139c746faff456f14755b7af7395b713bd70.1791574390.git.roma55592@yandex.ru>
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

On Fri,  9 Oct 2026 21:34:26 +0200
Roman Khromenok <roma55592@yandex.ru> wrote:

> Decode the compliance codes added by SFF-8472 Rev 12.5a and
> SFF-8636 Rev 2.12, as ethtool does since commits 057c4fd and
> 75d6232:
> 
> - SFF-8472 byte 10: Fibre Channel 1600 and 3200 MBytes/s.
> - SFF-8636 byte 133: SAS 24.0G, and SAS 12.0G which was defined
>   but not reported.
> - SFF-8636 byte 138: Fibre Channel 3200 MBytes/s.
> 
> Also decode the SFF-8472 Fibre Channel Speed 2 byte 62 (64GFC),
> which byte 10 bit 1 refers to. ethtool does not decode it.
> 
> Signed-off-by: Roman Khromenok <roma55592@yandex.ru>
> ---

AI feedback.


Subject: Re: [PATCH 1/2] ethdev: decode newer SFF compliance codes
 
Bit assignments match SFF-8472 Table 5-3 (byte 10, byte 62) and
SFF-8636 Table 6-17 (bytes 133, 138). Gating byte 62 on byte 10
bit 1 is correct, and the A0 buffer is always 256 bytes so the
byte 62 read is in bounds. Nothing blocking; a few small items.
 
[PATCH 1/2] ethdev: decode newer SFF compliance codes
 
Info:
- "FC: 64GFC" breaks the naming of every other entry in this
  group, which all give MBytes/sec. 64GFC is 6400 MBytes/sec:
 
	if ((data[10] & (1 << 1)) && (data[62] & (1 << 0)))
		sff_output_field(d, name, "FC: 6400 MBytes/sec");
 
- Refer to the ethtool commits 057c4fd and 75d6232 with
  12 character hashes and the subject in ("...") form, so they
  can be found without guessing.
 
