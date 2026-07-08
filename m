Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C867CC43458
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Jul 2026 01:46:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9A54540264;
	Wed,  8 Jul 2026 03:46:26 +0200 (CEST)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54]) by mails.dpdk.org (Postfix) with ESMTP id 61F0940041
 for <dev@dpdk.org>; Wed,  8 Jul 2026 03:46:25 +0200 (CEST)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-4703bc0a99aso70905f8f.3
 for <dev@dpdk.org>; Tue, 07 Jul 2026 18:46:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783475185; cv=none;
 d=google.com; s=arc-20260327;
 b=N43xOXPDly4eKrBHylu/PBf9TFMDt5kyquCmC4R8RsMtbdwDzS3FSp9TkdaI4Kh924
 Sy+V3s/LK2/uiRpS6pVwBekSRwxQ50NckDKanlQG0i/XAGLkot4A9y+zDG+DbtXoeNJz
 LWkh6VIItzH/5fmcXUywZsM0jByA8Nrx9JfZU8Iz8EXzNmBB/7La1BNU/2Le29EHGyb2
 kr9FpV01UoTpxUrQ4OQpIFdf2daa3tARFO1WJwVY6u2XCZUOHvSK0H3pEGstkeQCcbgJ
 W4OIaZk5gVYPU4IQLjFKvCvEyFrgUemvmZRvosncruzWPiSaPrYlGPmhIZ9qshQWNZj/
 kvEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=xAMZ329Obfv6Q2ef/ixRQVmAT2PwaUlmGbDNvQ+LU58=;
 fh=5fCWTlhKK96EFqlGWNsrLGUhMeEc/HiNYJSsTonxU4U=;
 b=hmdY/qMtwoCBtd7s1OqJP48Q0JYtxo/h01jkx8MHWmQmrQzS6A+4k9r7N1Ox9/s7XF
 WoDwNJHZKRqW3gVQ74UlrMkLNlTX8hTGHHS6SMx5gv8iOYZR8Xy1Zphm6VxNeYccyl8v
 T+p78HcWPif22HxxSJQFsHwfcHiSjS6TFS3Mk9+URtSiAVPC5C86MfWZlpyd/1BmpvpF
 xK1itVwzaY3ZdcmEmzIj9SJN2S1uuwKbB4WqgqMSuCIfetSKNg/Wj6gQtbmo/MCg+6eE
 ak/zDCZxzAoI2gF/0/4jk7R966b+v2hlUGCfSZEmRsS0lkeyHrlF3Pr39Oz7rEUrWtAB
 +X8w==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783475185; x=1784079985; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=xAMZ329Obfv6Q2ef/ixRQVmAT2PwaUlmGbDNvQ+LU58=;
 b=QENUqSoOmStkI1knHABbqdgzVuSihVxaZBgPAAuA4e8SH8CC/ohCDdS4th5H85dEFm
 y1sKdGkvprWEktLGDq6kg0iz5Dc0gzHyagQDJRTB/Ys+JSKW3a3JPSC4YrUqubbAgXKe
 hAJd9q5p2r2zzCoGZ9UPym+gey+uPAhyGVGf8F9kW7e57FhmKIwhtYAGxFt9iYazpErR
 xkGir+gHeeVGk0WIwJET7ZTiVPWbKde75DjEwwlgSOJZEZ6SPtP0gnSgPnYLieofWgGq
 ivZIIrMLcTzJytPkFvErmzkSSQ0sZCI8ZvGgkp3/TO7TujyeioF1YdtkZSd5VcYkwPm5
 RUFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783475185; x=1784079985;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=xAMZ329Obfv6Q2ef/ixRQVmAT2PwaUlmGbDNvQ+LU58=;
 b=pmDcPtO2WKge6s03Ykb7SbvMJk6ReKkb45uEnBITI/mUxgOdaQRZZIvPQ35TsmNwuz
 yXuCsUopdtpVjugUMjk8pBL4mBHD+4G6KPTd1/zCS2xK+brDwWlchSP6bHFIe2xv/J8I
 2hfHTq1PJ1QeXAgvcLHMPua5PBPvDjm3alPmvDVKnMtoIt0FzfzmXtSJW1kV53F1gjca
 voCVDRQIG9HWZg2vO386Jeayn/G6bn3yPek5mUItnxa38FnsJltnUp5btzLuLE35q/8Z
 F6DgY7IHHKECEc1yjFDfiOBGGyk0wbo/ifSfQG/sMFWlmbSeE7zg9678qOetFzMc9Yo8
 eOMw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrg5AYGT/1L3jpz5N/3jLtOuVSzKlVYmn9SYKzaqEdR930AfwZ6T3h1SNfWnqilij3n9Xg=@dpdk.org
X-Gm-Message-State: AOJu0Yx6pAu+5WD7HcD23i8XZkuRzJQDSYy1BQf90VH80xm/uid8ThfS
 IQQpwueg+MuHfuCLj9wJSk85RLIFdZEgNdh2zA1icjfOYY4DsovCrw9Zk3cXipWRIKlZeZn/sLP
 0mwXMYddUTo/RuwHQxpvxn63O37coWkQ=
X-Gm-Gg: AfdE7cneQgVIy/UCVx1Fy8xo9uLkoGlQuQ0o8R2I6FnxzN8XArdqewXCip6AvpSRZ6x
 08kdpeIzMLT2BqOF9CLmzqBBBMAaHMVWmaBGmJF6RbUBFo1Qv1YZqMCV2lNzVLT0r92dvTzQz3O
 IQhX1mnIJO0JbPeFd9A/fXF1WDsmv9Q5xrOdDbdfHdXn5cjGa3On8QHvoljYpbIzSmPDpnzrtcS
 FOvy8xIbJpqipfzr9HEMveiAwKxskl58fr45PszhqFhHD5GhsDkSvsfutIqPkoDTOL7psKNt9rO
 Mfs5lRFidJh9VR05DKafSY12yR86zBqn7PjSWhkKzx4ykWq4JybBtPlg
X-Received: by 2002:a05:6000:2909:b0:466:6d18:ae93 with SMTP id
 ffacd0b85a97d-47df073939cmr173458f8f.21.1783475184744; Tue, 07 Jul 2026
 18:46:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260602163647.101815-1-knimoji@iol.unh.edu>
 <20260625154712.2255474-1-knimoji@iol.unh.edu>
In-Reply-To: <20260625154712.2255474-1-knimoji@iol.unh.edu>
From: Patrick Robb <patrickrobb1997@gmail.com>
Date: Tue, 7 Jul 2026 21:46:13 -0400
X-Gm-Features: AVVi8CdkqqGLxUeHDT8uf3Yy5Y7Lk15RT2SHMdx0X0RCwMVj6VgdYZzbHrSqHn8
Message-ID: <CAK6DuxvEjRGOQJMY-Amd+QUxQBAV9ihp35fX1PQ2D5p7bt=L8w@mail.gmail.com>
Subject: Re: [PATCH v5] dts: report dut/NIC info during DTS run
To: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
Cc: luca.vizzarro@arm.com, dev@dpdk.org, abailey@iol.unh.edu, 
 ahassick@iol.unh.edu, lylavoie@iol.unh.edu
Content-Type: multipart/alternative; boundary="000000000000da3b9106560fac4c"
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

--000000000000da3b9106560fac4c
Content-Type: text/plain; charset="UTF-8"

Tested-by: Patrick Robb <patrickrobb1997@gmail.com>

--000000000000da3b9106560fac4c
Content-Type: text/html; charset="UTF-8"

<div dir="ltr">Tested-by: Patrick Robb &lt;<a href="mailto:patrickrobb1997@gmail.com">patrickrobb1997@gmail.com</a>&gt;</div>

--000000000000da3b9106560fac4c--
