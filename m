Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B403C02194
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 11:13:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C5CED42798;
	Fri,  7 Feb 2025 12:13:28 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id EB58940DFD
 for <dev@dpdk.org>; Fri,  7 Feb 2025 12:13:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738926806;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CALkzed+iZRbLuLDO8x+Xq35ymNbsRNL9Ns6P3B+/wc=;
 b=cD49D+K3AXpeJ87+z4tZjHsHcTBaGqw/EvODRkgNe494HdtayYnxZqMKlkeJp/DkAB/H+r
 IzywEeNpn4r0Zm7IBH5fhbc1UZjm3RYo8BxwtMEC2q5zXt7N/vvqJP7/F1P4y/gwEUAUEu
 Fk7nyBGEcaKFxWvbhG7GQG4RKIZTEew=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-2KJmdWQCO3itHHbpfVsIdA-1; Fri, 07 Feb 2025 06:13:25 -0500
X-MC-Unique: 2KJmdWQCO3itHHbpfVsIdA-1
X-Mimecast-MFC-AGG-ID: 2KJmdWQCO3itHHbpfVsIdA
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4361d4e8359so15195725e9.3
 for <dev@dpdk.org>; Fri, 07 Feb 2025 03:13:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738926804; x=1739531604;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=CALkzed+iZRbLuLDO8x+Xq35ymNbsRNL9Ns6P3B+/wc=;
 b=jil87RrDNTC0Kz+PRq400SxJSva2fGeC5VAuLc8RGmAsRapGFLJx+fogU6Eksj0VfC
 tfNXjlZ3N5Qd3+px2J56lvTUjWU5bhALeow6MOwUw4tqnwYOPbLzP2I51R4+wi8VSQO5
 E2WcMbFhhWT5ldk9HWww0u3rc8pSPdV3FpVqFhqUN9UU7bJJAlwM6chdKuhg6Ypf8jDE
 McJK3/1JCX7A93Vpot7gPn+azk5qhKtG8s3WI3P9HIFQgAI0E0EsVYjVSCokOz38p0R5
 29bi/2oCuXM8W+Dq+8/CL5XnhZMRUa2tAuvgUGrP6O75piL8Z/MbVCmwWtvfxUV0tNH9
 DHHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4dH/8WdNCJ0GglhMUvJH37yL0pEqVFMvdnfy+cYXCKnFg9m2rMmXJ5e3LwfcZGBNDSjo=@dpdk.org
X-Gm-Message-State: AOJu0YwUpzGbD47V0BILgzlDa0QnWTU6f90T3ruq7UFd90Fq1NGS07KI
 RH01M23JD6UkZSzqOOJzmuP6w/FEDIMkHNF0n/lkbj03qheCXA3kW2dGKshbwNtfDdc5d/UvvAQ
 oFwGS75zFZpvW8O8V1NMus++C1ntOyotzR63LrvPL
X-Gm-Gg: ASbGnctYWmjUA+CJTBrOJszIQuMnS2i/wAi0D8V11AtICVuSUpIz22l6jMcjVyFYZix
 0+reOyzoqVBIYEtroY76MQR/J68Z5cr0q4QF3xkl/jr+55T8Rb9ZwDJixJMsmBYyrwhEdJ9SV9/
 4cTCnMNoXkJVdo8OGamYigUYIOD1N4fLH29JXSQ+HxD4E0ZFuJFn/KsDpf2fBscM8RTQ3PNTVyz
 3WQD3b9HM9ITBI08nk+4Z4z2QSbG0NJUPoQnzjqSYwY1OqN72gWbqLHOcg5ICKE+2ZIjCVzOyzv
 LdgVEO53QLhb1GmBCBX0VdsbS4xyAyWLxYHAT6rpnk1y5M7Ek6PAJUuQG7xwQr+MEBo5
X-Received: by 2002:a05:600c:19c9:b0:434:a90b:94fe with SMTP id
 5b1f17b1804b1-43924988858mr25414215e9.10.1738926803861; 
 Fri, 07 Feb 2025 03:13:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHNvQjT1Wq37HGeTon6eOybk1TWLs2UCuM1Km/jmG5s8Q2xKPLoz5iCFGyIgaep4LfS3YGMEg==
X-Received: by 2002:a05:600c:19c9:b0:434:a90b:94fe with SMTP id
 5b1f17b1804b1-43924988858mr25413985e9.10.1738926803432; 
 Fri, 07 Feb 2025 03:13:23 -0800 (PST)
Received: from ?IPV6:2a06:5900:c00c:9000:256d:904:9b40:6d8b?
 ([2a06:5900:c00c:9000:256d:904:9b40:6d8b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4391dcae129sm50616655e9.17.2025.02.07.03.13.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Feb 2025 03:13:23 -0800 (PST)
Message-ID: <2b6e60c0-4436-44dd-bba2-335c1b22a7e9@redhat.com>
Date: Fri, 7 Feb 2025 11:13:22 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/2] net/af_xdp: Refactor af_xdp_tx_zc
To: Ariel Otilibili <ariel.otilibili@6wind.com>, dev@dpdk.org
Cc: stable@dpdk.org, Thomas Monjalon <thomas@monjalon.net>,
 David Marchand <david.marchand@redhat.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Ciara Loftus <ciara.loftus@intel.com>
References: <20250116195640.68885-1-ariel.otilibili@6wind.com>
 <20250207104552.1663519-1-ariel.otilibili@6wind.com>
 <20250207104552.1663519-3-ariel.otilibili@6wind.com>
From: Maryam Tahhan <mtahhan@redhat.com>
In-Reply-To: <20250207104552.1663519-3-ariel.otilibili@6wind.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7JIYX23_nAhy275UxoKpQX2CYA_BBQDqMUxwcEBcrkw_1738926804
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative;
 boundary="------------gL0P9kDMwsOksuKi263CRjF6"
Content-Language: en-US
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

This is a multi-part message in MIME format.
--------------gL0P9kDMwsOksuKi263CRjF6
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 07/02/2025 10:45, Ariel Otilibili wrote:
> Both legs of the loop share the same logic: the common parts are about
> reserving and filling both address and length into the description.
>
> This is moved into reserve_and_fill().
>
> Bugzilla ID: 1440
> Suggested-by: Maryam Tahhan<mtahhan@redhat.com>
> Signed-off-by: Ariel Otilibili<ariel.otilibili@6wind.com>

Acked-by: Maryam Tahhan<mtahhan@redhat.com>

--------------gL0P9kDMwsOksuKi263CRjF6
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 07/02/2025 10:45, Ariel Otilibili
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20250207104552.1663519-3-ariel.otilibili@6wind.com">
      <pre wrap="" class="moz-quote-pre">Both legs of the loop share the same logic: the common parts are about
reserving and filling both address and length into the description.

This is moved into reserve_and_fill().

Bugzilla ID: 1440
Suggested-by: Maryam Tahhan <a class="moz-txt-link-rfc2396E" href="mailto:mtahhan@redhat.com">&lt;mtahhan@redhat.com&gt;</a>
Signed-off-by: Ariel Otilibili <a class="moz-txt-link-rfc2396E" href="mailto:ariel.otilibili@6wind.com">&lt;ariel.otilibili@6wind.com&gt;</a>
</pre>
    </blockquote>
    <pre>Acked-by: Maryam Tahhan <a class="moz-txt-link-rfc2396E" href="mailto:mtahhan@redhat.com">&lt;mtahhan@redhat.com&gt;</a></pre>
  </body>
</html>

--------------gL0P9kDMwsOksuKi263CRjF6--

