Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 316BFCA0FF0
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 Aug 2025 15:11:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1C94B4025A;
	Fri, 29 Aug 2025 17:11:27 +0200 (CEST)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com
 [209.85.210.180])
 by mails.dpdk.org (Postfix) with ESMTP id 8D63F40150;
 Fri, 29 Aug 2025 17:11:26 +0200 (CEST)
Received: by mail-pf1-f180.google.com with SMTP id
 d2e1a72fcca58-7722bcb989aso772542b3a.1; 
 Fri, 29 Aug 2025 08:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756480285; x=1757085085; darn=dpdk.org;
 h=in-reply-to:references:cc:to:from:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=eTDm1Wp9V6BXDEH0D5hsseYQMb10VoFY5Gk/ewdKI3Y=;
 b=IbQRV/8VKmsODH47mw/iLwz0TvMNAMH9LYsCYjPm6Ey/vxorhPl+BYb+NnVByybK6T
 +g9KcdToDw2O1lBf9bbZ+QTI62xNr+5HYKocyQ2X9EDkLK3K20sGPtOPz5Nbo02etzVb
 VJ4N3qmWJ+q3XvsCNKCRixmnK30Zque7hUYtne/qhY5tKpaMmk+QWzCUr6lSwI3SYzul
 lmlO1zFLzEWAq28hVGafNxf9ReoFv3DwpZub+GTgYczmvkDNnVGCZPuVF/OUb3XbeTAK
 YOIMqQdFKIuvM95KRePqoxAvtoXk/d1tPUjbZ9A8TPCUie+ceK2cLt1LuJfNcgMvQex0
 VFmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756480285; x=1757085085;
 h=in-reply-to:references:cc:to:from:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eTDm1Wp9V6BXDEH0D5hsseYQMb10VoFY5Gk/ewdKI3Y=;
 b=EhB9y5eXMBSc29A5T3/Pgd00RUBho0PnYDeIjtsE9XRJV9zUDpbEldEiRV3oIYxqZV
 LssRCJYpUWImzPNrG8cKeOlBdY9JsI0S3myUhyecMcgBKD8hmI53Ei8uWQEllToK/Jxv
 P842bqptTsf2EWHBqtY0PehEUHN1Td1Q9bp1toSTClZn3HfGpSl1/UcjKzv2zifuilaD
 uY/i31+fEZhSjPiD2Ol9UD9gjehDbHH8dNoYI3noLRJzah0xokvrw08Wn7wj1ZTXb1Oj
 k4dTk49ztUZyHlJYaAeQC8nNTFFkhE78S6EHHOnmYOWcVYW6UU10F6bJGg/rk5jv9Amx
 666g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZwD/iWLrD0BCX2J19AGQtkuNMFsIBAuGumlBRRyyA0pDpDGm+HdvPpmvofBcrZC6mdDmN1vg=@dpdk.org
X-Gm-Message-State: AOJu0YxhAzBUIbbz3M6dMVE6YTtn2gSIRPEgXw3MdXDSoCEnEr6I9Kap
 g/yic6uBUzx+GJ3Adr3ITmzI39ZJIYVCiNw+ik8lTsB3izL1Z7M6YFhIKKD4V5KW
X-Gm-Gg: ASbGncsPHj/bXAUts1js2jNqnBGOYmMrBBM4S+aYmvLVIfRSJWUV8pP5KzyjjjRqgE6
 ewPKnW9WR+K3GZr21Wr/Gwt8XwUZRPlXcPnOCu1DjV9A+zpllkmgo/5g6r6AWnefRydVtc7LaLx
 TinBfm05g7Ai0L63O/Gmey/WmW5pqqr4CH8xyowH/uSPKiL6EfajFPaO7eAXPLjRsRVRbM4oIXF
 JNHjAEfW3PCj4BzI3JuT9/T8ais2kA7m8h/kVJJljR7MVnKM0itInhUJN3aNTFZxJ37uoQiuhX9
 8KUz9TqUhLGwiIYBZ4nU9rLEsFkNCtC6rpAQBeM9MZ1Q/nSSebSswKGrmKi7IDQa187PxPtW8fC
 h6qkfYMIo1QxHOAnvFfPN3b2ZyVV5Ak8qjml9wM8d1bteKMUvLNJN2JcNFw==
X-Google-Smtp-Source: AGHT+IFenflAsL/gUsgnizDXPtze7OLO3Vfrny3yY56xjVG6ldvJXWB3b/VDdE/yaQYUvLt+zPd5hA==
X-Received: by 2002:a05:6a00:4649:b0:772:b0:230f with SMTP id
 d2e1a72fcca58-77200b02622mr18166175b3a.24.1756480285133; 
 Fri, 29 Aug 2025 08:11:25 -0700 (PDT)
Received: from [192.168.31.142] ([125.120.234.137])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a4e5b44sm2618768b3a.88.2025.08.29.08.11.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Aug 2025 08:11:24 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------8HqgxWJogpb8bm1ZZoIKzWI0"
Message-ID: <f3e16d32-4eb7-4dd8-9f65-8ad874ce64ab@gmail.com>
Date: Fri, 29 Aug 2025 23:11:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] crypto/ipsec_mb: fix QP release in secondary
From: Moses Young <mosesyyoung@gmail.com>
To: dev@dpdk.org
Cc: kai.ji@intel.com, stable@dpdk.org
References: <20250407052532.1913-1-ming.1.yang@nokia-sbell.com>
 <20250719153227.1980-1-mosesyyoung@gmail.com>
 <20250719153227.1980-2-mosesyyoung@gmail.com>
In-Reply-To: <20250719153227.1980-2-mosesyyoung@gmail.com>
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
--------------8HqgxWJogpb8bm1ZZoIKzWI0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Experts,

is there any chance to review and accept this patch?

Brs,
Yang Ming

--------------8HqgxWJogpb8bm1ZZoIKzWI0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>Hi Experts,<br>
      <br>
      is there any chance to review and accept this patch?<br>
      <br>
      Brs,<br>
      Yang Ming</p>
    <span style="white-space: pre-wrap">
</span>
  </body>
</html>

--------------8HqgxWJogpb8bm1ZZoIKzWI0--
