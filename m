Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7183CC369AB
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Apr 2025 17:55:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 135D3400D7;
	Thu, 24 Apr 2025 19:55:49 +0200 (CEST)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com
 [209.85.128.181])
 by mails.dpdk.org (Postfix) with ESMTP id 37C5D400D5
 for <dev@dpdk.org>; Thu, 24 Apr 2025 19:55:48 +0200 (CEST)
Received: by mail-yw1-f181.google.com with SMTP id
 00721157ae682-70811611315so13498557b3.1
 for <dev@dpdk.org>; Thu, 24 Apr 2025 10:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1745517347; x=1746122147; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AgJrHBef5zcwd3I3J3Xb1mLyx7oYkhB7tM4DtxaDFMo=;
 b=QyQTpzX5vVs+D6vPjKuGjyXSNhJXULzRU8n8bbvtxe1+lq342GIYiyLwqWq0Nso9ks
 iv/+gZyn5ogkbSISsiqu1s0MsRcZIrm4jBwQPKwo4AFkXzVL6tS6Ax+4zQaLcTzTAUrY
 jSimzvcf1jtOYLmynM09rFMK5Llp3pjzpSoHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745517347; x=1746122147;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AgJrHBef5zcwd3I3J3Xb1mLyx7oYkhB7tM4DtxaDFMo=;
 b=szKKlnEBiwbgvzTb2bRyR1d38GpcjWLheppLgc3yIhN/EXcogjg5ER1bEDlPW4MCjC
 RkPXpDWxmvUCCMGRhpojFu1eHe0aADmyrdSdhkircwHdECavpNGP7hsPpq64b/TzIhGL
 8Bn2JwsRKmqmb0pkVHdQ59eSaGlGNePeqEHLET5PPfiFLbL1mCdPPA5PBaDO4xVCo3WB
 sbyn1w7r9fMRNCRtH1R0KZB85d4qaUntU65ZFfR0b2cyBd4a/mClVZQVhLqhmRFq4oMn
 fJMofevCo2MhISPe3oW48LGrSSQsuFqLFHduE4nzDvXyPzrueO6Xy6IPRT8i3o0om9ea
 ppsw==
X-Gm-Message-State: AOJu0YxAMwug56HVm2dbAnkm3kU7wIYPO7CUF+0SEYTU3RCPTThWR3tu
 50UI/wbKHx0Xy4yq4iZWq6rK5P3bvbhxqInqFV89JojkXEJhQukpm4Jzaw8SzrhNRR6ia+qq3zt
 GIK9kqLFyNcpAvml8WoWfLvBKPIU7owMDGA6Orw==
X-Gm-Gg: ASbGncvXFhsGbD3qy5PkJ/LLX8IgivUPcesk1Msrl1ahaWvKIOyt/d2y+eotVMWSGhs
 WHMt7J7/1FdCo0JfHgpJrsEbQqiNKWef89bhsHDKxucMLo52bzyFina4SClr5n25WSA10BZXAag
 UwmAR04Sy3H4GkSwvjXRy3D3yBAJOeXxpF/Lvr/Lt8gJM5Gvd+zU0UChn7
X-Google-Smtp-Source: AGHT+IEq7lGxHNACS9T64xJL0wc7LPKcGS/LtS6JauHxYgq4GoWEFeNIBZWs56Dv3Mt8ck72An0OdPd4rTJwoYMro3g=
X-Received: by 2002:a05:690c:6408:b0:6ff:1c1a:f61f with SMTP id
 00721157ae682-7084f13355fmr10719387b3.30.1745517347399; Thu, 24 Apr 2025
 10:55:47 -0700 (PDT)
MIME-Version: 1.0
References: <20241220172337.2194523-1-luca.vizzarro@arm.com>
 <20250314131857.1298247-1-luca.vizzarro@arm.com>
 <20250314131857.1298247-2-luca.vizzarro@arm.com>
In-Reply-To: <20250314131857.1298247-2-luca.vizzarro@arm.com>
From: Dean Marx <dmarx@iol.unh.edu>
Date: Thu, 24 Apr 2025 13:55:36 -0400
X-Gm-Features: ATxdqUGRIrSfHr89wfqXUk4x5CUxiQf0jYbJ87G7WnIuNd5laMUJBvzLB6vcIR8
Message-ID: <CABD7UXPQCK2zuZgjTBkU+Tz_96WQsgce6ZFaGo4FbCtFOmFn-g@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] dts: escape single quotes
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

Reviewed-by: Dean Marx <dmarx@iol.unh.edu>
