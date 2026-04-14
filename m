Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30386F9D0F2
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Apr 2026 20:45:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 404E34028F;
	Tue, 14 Apr 2026 22:45:36 +0200 (CEST)
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com
 [74.125.82.175]) by mails.dpdk.org (Postfix) with ESMTP id F091F4028D
 for <dev@dpdk.org>; Tue, 14 Apr 2026 22:45:34 +0200 (CEST)
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-2d52c7f92b1so5347783eec.0
 for <dev@dpdk.org>; Tue, 14 Apr 2026 13:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776199534;
 x=1776804334; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yf1ttXzAYntWOenv/LpbQEgkano0BwigQsPUKPzoni8=;
 b=q6r/Do4fcFPXJ50SZFbOg1tXCEzrQRqIjaN5qozNhI5PMutCN0zjjg/K7+hQd8m7K1
 4y70zAO8aZTt/wYPdD1qibL/G+r4AiVf3qrUZCq8vDf+d5bhKyPWQuMS4aWprfRlkYZ3
 XJe3l31chNtavCcBRyNH+hFX9zTmjvSLVXmz7bLrdB0qZKBGYsEKoFbC7xcoIbxh+E/e
 EXUE+iTSZGP2UbEL7qZVolIfAvqAiHk4KA6f/bmJOoDe3AWYj4yKGa7tGVNLild71RK/
 e9ixAycYQWla8mfqq6Rrxf6fgeih1ojS37PDixYaYGCgt8ej613xPGh6Le4cWWF1NvU9
 QSYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776199534; x=1776804334;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yf1ttXzAYntWOenv/LpbQEgkano0BwigQsPUKPzoni8=;
 b=nrMMDy2VCajeXxKJxkCxtMd0cIRQv7vLU7dkvs4llTsNYvPsyQnY2X/oVdz3sXI2qy
 hu5DWLB2PlJ9JPUL9hpmrHgwyoRgSD71AFtWoL3c9j82Kc6TnVq2Mz4ki2m9tIn5tW2T
 Pe45Ynw1idf+4V4jVIsCKlzo9LJWfoObKQCSDMPD0mr1cIFitJASiRtr0n40MmcUT+R9
 3E/ObNnQ1uC9Ye/69UmC6a0Bj5jSSwID8iNOVQLZBoyHE/geB9+FJDA4T+QBg1SPXPss
 8RouYXEeqlgwY0NkxQKpT9rGXvdXgNg98L+klyUhUuTzKaLPtQsryHQYnbAQvXRJpDoq
 Rs2w==
X-Gm-Message-State: AOJu0YwXhnz4tnWY+mji0TuBzjD+7sBL1Nh3Ur9Xw/9UrWFtKAcvDOBF
 jydC30UkxF6UNM2URA7i8rqiwdleasf+uOBEPi77zHrge60PlFf6O8fz2vBtv792G6k=
X-Gm-Gg: AeBDiesew6a2bVDFo+355mQwtuv8N+VTkeNiktt8RjTIVK8xo9+T6o6WUXW+OgxFGM1
 0YeyeSlgOOGQQ1HwL77zYanQv4jxoZMsUuEQAgu7lSHni9UcEDoOYpvJADwLI11I579v8vzjwvj
 9n6RkD27Jw4xwgzN/2FY13AK9qoont/RyoatpiEwhpYzZ4/AmAdF+9N3FdDAEfXHkqKm9FWWOdY
 R5F5KVloUQugDHZHvoZm2K2LA/JEcV5aOfCglKOVF6OTP6Nzeidnd63zE/Vna7ZU+bwTwI8Cj0i
 7gzItl6Sck5zi/3u8hx3w+hD9a1jLUwaP2Uqi+wB+M4FzlTEgIEi1eEhJnbrhBl4dLdOMxEVYgx
 8DNuuZICxf0UVM5OVBlHk4niL8mBOurCtdGzZFk1WkxPMGLPxBNXapduokXMDVut2YZ2F8fU06A
 rJbbXszoclAqYVING3Hjj0nHDCdGbRHbeQJ3u92WF4VEe4eA==
X-Received: by 2002:a05:7300:7249:b0:2d9:89c8:8893 with SMTP id
 5a478bee46e88-2d989c8be4bmr5183789eec.3.1776199533806; 
 Tue, 14 Apr 2026 13:45:33 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2d562db64c4sm22258547eec.27.2026.04.14.13.45.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 13:45:33 -0700 (PDT)
Date: Tue, 14 Apr 2026 13:45:30 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Aaron Conole <aconole@redhat.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v13 1/6] doc: add AGENTS.md for AI code review tools
Message-ID: <20260414134530.5f827466@phoenix.local>
In-Reply-To: <f7tbjfl9v22.fsf@redhat.com>
References: <20260126184205.104629-1-stephen@networkplumber.org>
 <20260402194618.134002-1-stephen@networkplumber.org>
 <20260402194618.134002-2-stephen@networkplumber.org>
 <f7tbjfl9v22.fsf@redhat.com>
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

On Tue, 14 Apr 2026 15:54:45 -0400
Aaron Conole <aconole@redhat.com> wrote:

> I am not a prompt optimization engineer, but I've been told by one that
> we should try to avoid 'do not' type orders in favor of 'do' orders.
> That's maybe a good second pass optimization, because we have a mix.  On
> the plus side, there are also lots of examples of good behavior in here,
> which I was also told is a good thing to include.

A lot of the 'do not' orders in current prompt are to suppress false
positives. Mostly AI edits after telling it to shut up about something.
