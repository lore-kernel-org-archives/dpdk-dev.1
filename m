Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 036E0C5518E
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Feb 2026 10:09:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8B2E84042E;
	Fri, 20 Feb 2026 11:09:34 +0100 (CET)
Received: from mail-yx1-f66.google.com (mail-yx1-f66.google.com
 [74.125.224.66]) by mails.dpdk.org (Postfix) with ESMTP id 99124402EA
 for <dev@dpdk.org>; Thu, 19 Feb 2026 16:25:59 +0100 (CET)
Received: by mail-yx1-f66.google.com with SMTP id
 956f58d0204a3-64ae2ce2fe1so1033299d50.1
 for <dev@dpdk.org>; Thu, 19 Feb 2026 07:25:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771514759; cv=none;
 d=google.com; s=arc-20240605;
 b=NhBL7YvpyKKzaQN5eZfkbWdt6bAXlUzLTSzZJh6PTHeQSJo8QiCYVEovUpVqgbPZ7K
 WPv8ZRwMWh3y3u2eB8BtnIp2cOefMkoFvHMTVg0g3rVvps+W6rluCJXrXu5hpImcjpeN
 h+m8P7xDWxpEPLgSWjLxVrosnPTYgDr+64o/6rS5Nn/UcWUdSIn+9lzyzTnP8mMyty8C
 Op8c2jcQ4uRNNFVQl6M7HlM8/PI8wYN/yoMJShgj13LLMvp3bSwOQoZ3zOYs74mXjN0k
 zpjlapjaHcDIzvSMOeLVbsn1sK78GNzcPEb+47MPYtrr1oTqbJuz3J7PrAclNRl/LXyu
 oitg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=FvBhdx9YNfP6WNlB/cewzAy1RmBo4K1YBdot9RCwJsY=;
 fh=eUqWHLlhrxpykrabbQYbmT5B5FclN6p18glcXqrZikU=;
 b=bEytF2lOtKNExTIiS6AbTqssLoFhnwWW20J3G0PHnTYeAvw59cqCGvafTSid2m4qcy
 SS+BUbRy11s3Q7tZ2Y75TZ8SZSb/9a+02iMi31oV9K35xNPXBXqxVS6q/BSVInDf70G1
 sQx7J/08AyJzC1odAUocJ1PB5k6zpzQkXycZ2c0dMNLoRKU4ZFX1HtnWUSN2kMWow3nE
 ah9vE/d6V35CeiI9l0IgFGkMIw4Weqc29LMvEx9fLphBACwgc1neKgqveugRaJPrzIDf
 uZ2hzpX3iKHVllFzlnFP7q84T+1Vc67qGbQ4WaL1+qVs9VeoDQGpczJ9dv8F2qJ+FoiN
 yeLg==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771514759; x=1772119559; darn=dpdk.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=FvBhdx9YNfP6WNlB/cewzAy1RmBo4K1YBdot9RCwJsY=;
 b=MmWOusZrRPL00Wuok+fnVNHpAckOZHCS5rUqilF9+C+vVCkeFcZ5LyISCdwdVuunV7
 Iz7Y3Tnc155t5SJDHvX1/G5e8l06vHBTa16zwdUbnIuLFkuZRSXertBgD7o1cMi29vVH
 iSrgqrnyeMolRsjrkSFgeCkFbslHxkLkbzKnGjGip9iM1LiDbkEr3ML91FCyHxeBTi6h
 M8a4mCfZj2/iQh+b8A0uI79blSylcYHIOtAV8RrfVNA/T07g5dYOfDhZstOan/C8ipHY
 mP2/c2oLfsS1BJ1DrbopFarbV2M/Gpt0mzjAwHcTlEl9ZRS9be2TQ8ylnQ40eHDKVr3Y
 nfMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771514759; x=1772119559;
 h=to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FvBhdx9YNfP6WNlB/cewzAy1RmBo4K1YBdot9RCwJsY=;
 b=J6nfq4rYAmjRifEMTR5uR8g4oDOIjqybXhgAtIPSQvtjesm/Ck52xgB2Y3ScXdSVpD
 XYDYAg2LSUkz8KUCPWT+jiJykOhghWuXp8wnpsFUv8l/hlgEQ08gaOxVanZ2+cIRMVc3
 xfrvzdraQ1csjpWmM3ehF1vn7JH1gwUcOqkpxqczTGYpmzQUvQZqTOhkWtbxB4n+Bs57
 UjzsLyDyxkS1i96p2k/9yr5BWNPIXVJqOSJpZ9XHa8YdoS2e3sLF/1ZtFXgn/gRo4tuu
 dzMmhUvogl/nNo1SIMumXvehqE4TJ1cSke9Yjf3qfu9+2vpO9H5vPaVxm2hzvqazr+rI
 wj/g==
X-Gm-Message-State: AOJu0YyW+nN0c2+raiUtq6fvyrZPs0K/9UsqIaSLmPFafyI+8kV/gQlu
 CD9SO5jL/on1up6NgzWQmRws8ZHz/OSfbfUKsK/cvzrJrQYHxK8B8tftQboKSQkLGS3Eci27nLG
 jHtITuiBqNqWTpM4mjhowHvx5zrQz5DY0VvJU
X-Gm-Gg: AZuq6aLGzwc9cwGzGexzYjuCVoAf5mDienmZVm1ANtj1ThJgIhuv2PI4+Jg7bNfMO2n
 SvDpJjkx/Xvsq8r5GWiL4n5rG9YrNjsrhYEWNOounsn2WTwPWteBH7XlmJUv+fGJrSK7SLAoLEH
 hihpQkWID65enCDCbIw4u8wZQOH3eEpN3vZfTF10E+N25K6zmKKNb9SYFsXT2I4VVX8TzMOSrBr
 SWsMSAVd7fBh6IsqwVZ4BxOD+Ot1oYiwF2pr+ZDYQFV+bGT4linQ3ULPRykf/6vtGckxymJmaze
 bQTgpZA=
X-Received: by 2002:a05:690e:168c:b0:649:ec90:e295 with SMTP id
 956f58d0204a3-64c55562512mr4797139d50.18.1771514758655; Thu, 19 Feb 2026
 07:25:58 -0800 (PST)
MIME-Version: 1.0
From: reza firoozi <rfiroozi257@gmail.com>
Date: Thu, 19 Feb 2026 18:55:41 +0330
X-Gm-Features: AaiRm52OhNBxkYyHHdPp2AuZ8NHGsrlyp4-CpPJBx8mGOPkm8MH9AZ1JpEcoc64
Message-ID: <CAC=Da-1K8qPRsYPpgcQHfZVycRigj3iNNoJ-mmShwjpsKsqysQ@mail.gmail.com>
Subject: Re: [PATCH v6 11/18] net/mlx5: add HW steering VLAN push, pop and VID
 modify flow actions
To: dev@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000e7737d064b2eebef"
X-Mailman-Approved-At: Fri, 20 Feb 2026 11:09:31 +0100
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

--000000000000e7737d064b2eebef
Content-Type: text/plain; charset="UTF-8"



--000000000000e7737d064b2eebef
Content-Type: text/html; charset="UTF-8"

<div dir="auto"></div>

--000000000000e7737d064b2eebef--
