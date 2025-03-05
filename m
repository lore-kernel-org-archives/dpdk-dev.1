Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0805C19F32
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Mar 2025 21:30:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DF03F4042F;
	Wed,  5 Mar 2025 22:30:02 +0100 (CET)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com
 [209.85.128.182])
 by mails.dpdk.org (Postfix) with ESMTP id EE6E94042F
 for <dev@dpdk.org>; Wed,  5 Mar 2025 22:30:01 +0100 (CET)
Received: by mail-yw1-f182.google.com with SMTP id
 00721157ae682-6feb0742878so1162307b3.2
 for <dev@dpdk.org>; Wed, 05 Mar 2025 13:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1741210201; x=1741815001; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/Hdj4PpMyN14VPpHjiI9sVWdyTn7ynQEywCKZhaq4Ig=;
 b=WTtk5vHvIOn26xpucVN35u5GZ6NFf5pcdOnDJ3ZifJkaCKF48z1027mOUSjHvZj3vd
 0AhmkLWXHAhDFOh0W21/1KULLBuABUmfP7MyaImP4ZEcdSwWPZnt+F/WOlfDQCqhv12R
 76tC8maf/9h+EYWNdl52C0y1q8p1EfMrsfjPI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741210201; x=1741815001;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/Hdj4PpMyN14VPpHjiI9sVWdyTn7ynQEywCKZhaq4Ig=;
 b=jRP1L66m76qaBJgB/Zb37uzidd7IIa/EWFuOqO2zdzwVR9odmkFM6Qybx1Z2BoUj2R
 de8bTuuQzRjoMcC+gJkhLNW01zz4/TmYZSxpfAF/D/yqMaEpS0ufNHNUONOP4wDDsD+w
 FG1Cy42QDbNoMPjrpF29thxmcd2B4dD60Z5CZusYiNTzTzPg759ZIEN0V35MicqatgyT
 FilNCGvt5DBKbaCggaqDECPQ6DjnQFtUzDqD+NXyup2dxgqMfzd3phDasjmBBCRi+glO
 qX2VMVM0sX0HcF6rYyOoYFD6K4PaNzRpzQCzLPdT/9DBXQTzcfGoYDphVdySJjGmPHm1
 clSg==
X-Gm-Message-State: AOJu0YzNi68b+un9Ib6I4yhu+IWTua3HhB0DRit7tHkmBhRU/qD9EuXQ
 s8Z1Ot0U09x9mc5P0vl2xWTQ+y+ihSqWKc4PGAEHZt47MiWM6PJcgJRoLLrrX2sL1IQPklkWVFs
 g+cyzXFP79xEzM/mLXJIQsCVGggDOpUGFy5MOcw==
X-Gm-Gg: ASbGncttqq/1mTRMwepsfW0Ov9KXwCvHWO4bW133Qi9PC9l2dRu2AcJqGgsrHn2qjP3
 VDqwyzXsrkA4fOudcaKIb1pWJ4UJRJxLuel4dQqiGlyKQW50rPmxEoPyOSNITktqN7w7yelcBw6
 TY212hajRXDqRAWkQpj2kZ+QsAO8mYZPse/g/kn3i2gUYCcXfsHO0xtR1aUHel
X-Google-Smtp-Source: AGHT+IFBZ1WbHNtNTNYx8v7zfBKYExIG3FTSkCclnM6NcHVi63OjgvqpTc++lOhQW3XQzDnCKZQZe06rK7Ipq4eM4NA=
X-Received: by 2002:a05:690c:48c2:b0:6fd:a226:fb2b with SMTP id
 00721157ae682-6fda2f04280mr71203807b3.3.1741210201306; Wed, 05 Mar 2025
 13:30:01 -0800 (PST)
MIME-Version: 1.0
References: <20250224132823.196509-1-luca.vizzarro@arm.com>
 <20250224132823.196509-4-luca.vizzarro@arm.com>
In-Reply-To: <20250224132823.196509-4-luca.vizzarro@arm.com>
From: Dean Marx <dmarx@iol.unh.edu>
Date: Wed, 5 Mar 2025 16:29:50 -0500
X-Gm-Features: AQ5f1JoN6wbLbvF2TfeeNEdI2bmVu9DgfUDTtTH_EO6pctUXDA_9Iti-wfTO6XA
Message-ID: <CABD7UXNmGggR7MMysLVcyF=80WzOaee-eDcenVgFNoThrdPa4A@mail.gmail.com>
Subject: Re: [PATCH 3/6] dts: add tmp directory facility
To: Luca Vizzarro <luca.vizzarro@arm.com>
Cc: dev@dpdk.org, Paul Szczepanek <paul.szczepanek@arm.com>,
 Patrick Robb <probb@iol.unh.edu>
Content-Type: text/plain; charset="UTF-8"
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

This makes sense, I noticed though that nothing is actually stored in
these placeholder directories yet, and dpdk is built in a separate
folder. Is the plan in the future to move this to the placeholder
directory? Or is there a different use case?

Reviewed-by: Dean Marx <dmarx@iol.unh.edu>
