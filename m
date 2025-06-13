Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2683FC71135
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Jun 2025 09:48:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5012B42E4E;
	Fri, 13 Jun 2025 11:48:36 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id A0C4840151
 for <dev@dpdk.org>; Fri, 13 Jun 2025 11:48:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749808113;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:autocrypt:autocrypt;
 bh=vwc5dAv4NvJ1H8XixNjiwMsk3bvOJP2jgAPplMTCgtg=;
 b=Yo8SISe5aHh2Rj0gj43OEuwdqksMegKp4rD0yJSZkbSmGiDapHhYADdrdMO7rEHcBAFxyi
 z21xhkScf70+zRsanQh2ZvZxXbVSOtbA25niQYuE0hZ6XNVlkE1H9SeH9FqO2Ekl++EUUq
 7L3RKr2J/f0wpXjp/MpHvUttyzRJPUw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-9mfwARaUMNC3mo9xkDhkdQ-1; Fri, 13 Jun 2025 05:48:32 -0400
X-MC-Unique: 9mfwARaUMNC3mo9xkDhkdQ-1
X-Mimecast-MFC-AGG-ID: 9mfwARaUMNC3mo9xkDhkdQ_1749808111
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-453018b4ddeso10485685e9.3
 for <dev@dpdk.org>; Fri, 13 Jun 2025 02:48:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749808110; x=1750412910;
 h=content-transfer-encoding:autocrypt:subject:from:to
 :content-language:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vwc5dAv4NvJ1H8XixNjiwMsk3bvOJP2jgAPplMTCgtg=;
 b=j89/lGThGvFDsWJR1KsAcDnOwLkkmTCkbto/c+WcKwAGUeUj5jCElZCTiQoSscfQxC
 fEReF1Ni8mPexyRHXy0skA9fCDBEaH6NiRG83D0Nl9BAT+MYfalfjcIppF1UXynYWueb
 f2e8GylcwOTEyfP4CTT0uhO4VbmJPMogXUyrJPWmAEa5kj+WML2nHIrXbmMFBAGyITb5
 Pe/JcolilV6H2djSe49JZ/+zcACkJlDz1niw7m+J0EE7gdExBiiwMMVvSgf3kyjJtlJ6
 kIclKiqeJjdVY2ZA68JVTGm5q9hbxQrh/Ox6SPigJFWG75eYKooX/Im1yTeAIOxgxxPb
 Q5qQ==
X-Gm-Message-State: AOJu0YyKmCGrhDCwkQm/DP5TMiwx/3XcuJ/Iqjqge8kGUrmOsF4KanxB
 pU3ML8M4xE2iecDXfGXIKM1aSErmk0kvGhVYf5op0i4VY84vfI1zaxaVd09MvDUEh8HrIeLw5ye
 vxq8pVOfyrk46kSU1+noBBEpRYtQPI8eBWbGmduAa+ZDaCYP99zhhE+p6fL/05LlAcdxRcg3uwW
 QSQQiC8ksBfp5CWjTAQ8kkoK71bZ+o
X-Gm-Gg: ASbGnct4D3OGraBZM5VvzrfQyPG7HcysLKdgZ3S6FOaRn9U1LWfMBEFMGweqMw9hjQz
 ag3o4mSa88+UfDNCZsKFdLOEE2CvwNDHGGskXmcKALtVI/fjm9Z010dkPxLEfPnLC7V6LVpLYLS
 3+ey8XUrMsddM6sMk7jOvmqM3JTG00RJTbU98eWIfnbW1WMN3MT3/3M0cob/F4jInrG1S6CZKlW
 ZXqFD0flgVG40yqgrDe5d9XI9nhkvCAf3G/7ZAebm+3OY1+SEsIK5AP9xQZZh3I4vP1qOqPvepy
 K/L+Bs4xWnXGRoPpLeM0gQ7w
X-Received: by 2002:a05:6000:2f82:b0:3a4:cf10:28f with SMTP id
 ffacd0b85a97d-3a5687579afmr2321273f8f.31.1749808110506; 
 Fri, 13 Jun 2025 02:48:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2QBvoC/EH28S2qY+7qxA3AOEbzKDGVP1HdF2CNroYXUzR9DZJi/kgrQ6wSInHD/MfNUCjdw==
X-Received: by 2002:a05:6000:2f82:b0:3a4:cf10:28f with SMTP id
 ffacd0b85a97d-3a5687579afmr2321230f8f.31.1749808109925; 
 Fri, 13 Jun 2025 02:48:29 -0700 (PDT)
Received: from [192.168.0.56] ([78.16.130.111])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a568a7cb65sm1872036f8f.38.2025.06.13.02.48.29
 for <dev@dpdk.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Jun 2025 02:48:29 -0700 (PDT)
Message-ID: <8782e9dd-1df3-4a12-a24f-dc16352deced@redhat.com>
Date: Fri, 13 Jun 2025 10:48:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: "dev@dpdk.org" <dev@dpdk.org>
From: Kevin Traynor <ktraynor@redhat.com>
Subject: Minutes of Technical Board Meeting, 2025-June-11
Autocrypt: addr=ktraynor@redhat.com; keydata=
 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
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qILP8bvU-mE5Rk6rEI2ffsrfx6z5qQZg-mFZY5o4FoI_1749808111
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
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

Minutes of Technical Board Meeting, 2025-June-11

Members Attending
-----------------
-Aaron
-Bruce
-Jerin
-Kevin
-Morten
-Stephen
-Thomas

NOTE: The technical board meetings every second Wednesday at
https://zoom-lfx.platform.linuxfoundation.org/meeting/96459488340?password=d808f1f6-0a28-4165-929e-5a5bcae7efeb
at 3 pm UTC.
Meetings are public, and DPDK community members are welcome to attend.
NOTE: Next meeting will be on Wednesday 2025- June - 25th @3pm UTC, and
will be chaired by Maxime.

1) MACB Driver Enablement (Stephen)
- Better to take pmd when the kmod is approved
- Do we still want to allow kernel modules ? perhaps if it is strictly
required for a vendor

2) AI meeting notes (Aaron)
- AI companion will be used to summarize techboard meetings
- This will be used to help minute taker compose summary to send out
- AI: Kevin contact meeting owner (Nathan) about this

3) github AI for code reviews (Aaron/Jerin)
- sourcery-ai may be able to help with code reviews
- It will require new branches being created with PRs on github
- Preference not to do that in existing dpdk github repo
- AI: Jerin will propose a workflow

4) ethdev maintainer (Thomas)
- There is need for more help with ethdev
- Other areas also require maintainers
- An email will be sent on announce to advertise
- AI: Kevin to draft email for review

5) ABI stability (Previous meeting)
- Proposal to only guarantee ABI stability on LTS minor releases
- Will need to ensure that ABI breaks are still flagged during reviews
- This will need to be discussed more. Topic for US summit.

6) US summit (Stephen)
- AI: Kevin request Nathan to give an update at next techboard

