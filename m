Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9EC6C88E50
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 06:54:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 971E8402D2;
	Mon, 14 Sep 2026 08:54:14 +0200 (CEST)
Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com
 [74.125.224.140])
 by mails.dpdk.org (Postfix) with ESMTP id 46B004028E
 for <dev@dpdk.org>; Mon, 14 Sep 2026 08:54:13 +0200 (CEST)
Received: by mail-yx2-f12.google.com with SMTP id
 00721157ae682-85d43da99easo15173637b3.1
 for <dev@dpdk.org>; Sun, 13 Sep 2026 23:54:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789368852; cv=none;
 d=google.com; s=arc-20260327;
 b=ek8dGEhJEJfV2xhok6tB6H6+rqvGDA2nYZ3AHmaC/JIUZ6H5zu+uzir4MOtCT6FnFc
 2EBowNZuLTc6iBDagMqKagPm1O50yim/+I+C/GUOcsZTe7UnGCjxeCvYvUsJKVkMJlXe
 M31o06+pvo1I9uidP4FwctPDubiIZFeaMzV0BwNT6TXAFfpZQC8kYoa9uBL5kWm6pezs
 MmPUVgeX8KZCIkJ75zUU3tbvNF4tfl9vYCUvx2olXf4w4B0VZW5WEMt1ZNmfezfskiDM
 UUk553nlGp7r5SWd3JNh8YHBhoCd4fre6WxjTv1yx8qmVTHmPf8rQ5R0vUTCx9jCVnf7
 Ubwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=G487clJFy4Rt6iHdRRckN5KyCsPtKjRUopKTNRiNwnU=;
 fh=u9LL6G1r40ffeF6ssWrz3ZzTm5mS3P1VOtawKhMD66U=;
 b=RCb/brSH8bXc/P6mRvtmS1CNnxZjbICQLE4zmON9cgkFsQZSgmHmpGL0NxRFkp/PcF
 wPDMUeswRTAKeiQ83YBE3rRF5ZrcovOfWdnrDO2nryR0uVPfUH7cENt0p9DsEenQwiMa
 +DYACC3uR7vQTJ8VJXi7xAVbF7eLEp2sY4psLVxJDd8lZwNbhajChb9Pt8H0K4MIHvJA
 iqw1ohZuLbzBQYnMZdKj90bO6s3lJLw2q4JqjRnRnZroFg6cbjQ4GluZOnikIz4Cf+aJ
 sMxkD/NgHWW9KvdXG3oKwu08FxJVN2BQqD2q7yZqODFFGJ+df++UrJeVpbtHiNOw3pd3
 ytjg==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789368852; x=1789973652; darn=dpdk.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=G487clJFy4Rt6iHdRRckN5KyCsPtKjRUopKTNRiNwnU=;
 b=bA+uSSoJ8gw9CkmrhcD20EIHsVLsY1s1mBnMIaLn6yl7rIOirAqpX2hIwZY0zKFT32
 ZNKhSGXBDZJi90ejcvMOJEWULJndqE4+5jPjdKQMvHwd+GbDJVhlUc2h91/T8y/icsRm
 eTcowhN8V4KhjaN2vo6Uuaf9nzcF5PGLN4K6sZSdGNhcwJjdpUY2EtfMZ531v3DQPVAF
 x6rMbcEm6UyDYC7h2MKpYPStE9Lc3X4no8Cdk7IJQxVFP0A0jCClg8AYLhENeq/j0K0a
 ysSjQyOXcDODdLTk4mupEmntYQyHau1+urH4epfFvnHHUaYldbm75qn7RSJ7c12FkLup
 3ikA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789368852; x=1789973652;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=G487clJFy4Rt6iHdRRckN5KyCsPtKjRUopKTNRiNwnU=;
 b=mob66ZIFUSF1C2TVmifpJwGwip1VJkmzt/jth1hldxVyWEOIP4sd08xFVpOls37zZ8
 RW3wP4xNMV3dUcH+fFpWpZlckiBmesheVOZjT+azwkatb3vI/nDNmqLaRtVQNbIGWRTV
 ctdEldV8ef5hgCsCSEpUduBWBHr/2KUd4d8zuC7qLpKwtszx+D9or6LZh8VDCBiI0Btj
 mZUUkCF0kGPv4DEdcoFrNFBVPd30i7ic+6SSU/WYumhTc91cBPQmutxDjCwxyaHP+UP9
 GUe1geFPuMCy573TLBCYUJp8RCwhLEOAjpTg/kjn5YIlqMFDJ0TbmU3THc+WkueS1eEY
 28Mw==
X-Forwarded-Encrypted: i=1;
 AKwUvByLIDhwc8+7qLc7kxV5/FjYjYkXCq6JCr1pDZgYE92Du+f+cajDhFER9bJAOStJaRQfUcc=@dpdk.org
X-Gm-Message-State: AFuF++mDy1VqpYe5gaC+H0NqXYGNQHFBpXW2qbOi46rz93Y+x8+rO/5n
 L8azPlvHBQI7qOscoLPmooWUsULYCHgjEqHq8kD8o2pEQZvlF8dIEPDIYXGgKiDqlQ+UaAIPblj
 E7Xlfxp+wSqUNFvJf8N6UYYSEARFsabs=
X-Gm-Gg: AYBFou2G/1rn31muoDOcM72fkMJmPdj/BUBPvMMjB8H4JMVexRdJKcOo/jd4ySSYnrr
 bJeoI4AmCDej0LxpHS4FxL5pu7gq7D7K25FL2k0TsnI04JH0jnpOclrt6A0LQwJbbRloJiCP2Bu
 mEZ89ODmIuD6EDcmaYHggwyWyuhHFy7Q/V9OBpVTiEEVGi6p2e4Ej7bTQvcwFdya4nR8jFOkLEQ
 x5/GFRnTOB1sRLF4AiBslOhMeTkTtFcB8UBg9ErY0GxJA8Cl5ZmyGgJPNfJKaJIEYFTzKsVBW8Z
 bnTtz8EGjwJFCQLZlHVTomXvECKCTTa+jnaFwb8Zb26H1d6wKz895Ugqa+FKmqFg02U7JrhXYLl
 Z6ZM491bV5C/z4AOoGZ62vWXNMRdpZwUwbLsm4guD57O3Qn1Uofs6WCYoRJ/MZjuKxmOyF4I6FP
 gdnQkGyTPKnzjUJdlO
X-Received: by 2002:a05:690c:e14f:b0:873:5bd1:98c7 with SMTP id
 00721157ae682-88d23d98babmr1843307b3.57.1789368852527; Sun, 13 Sep 2026
 23:54:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260715084545.301064-1-ykanaujia@marvell.com>
In-Reply-To: <20260715084545.301064-1-ykanaujia@marvell.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Mon, 14 Sep 2026 12:23:46 +0530
X-Gm-Features: AcwNN1UD7tu4NtUZTmW_HxE2RQe4rr0-X18fI1BOc85fnWehwGtq4Qiw7Sdv8dA
Message-ID: <CALBAE1MCnMyAj7Gn3ntcMFkTSq0uum7=jipnEoesNT3_4K1YhA@mail.gmail.com>
Subject: Re: [PATCH 2/2] drivers: add support for async RTE FLOW APIs
To: ykanaujia@marvell.com
Cc: Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>, 
 Sunil Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>, 
 Harman Kalra <hkalra@marvell.com>, dev@dpdk.org
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

On Sat, Jul 18, 2026 at 2:48=E2=80=AFPM <ykanaujia@marvell.com> wrote:
>
> From: Yashaswini Kanaujia <ykanaujia@marvell.com>
>
> added support for asynchronous rte_flow APIs
> for cn10k device
>
> Signed-off-by: Yashaswini Kanaujia <ykanaujia@marvell.com>

# replaced _attribute__((__packed__)) with __plt_packed_end
# Updated .mailmap

and

Series applied to dpdk-next-net-mrvl/for-main. Thanks
