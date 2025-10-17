Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81BBBCCD199
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Oct 2025 15:08:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C7F6942DBD;
	Fri, 17 Oct 2025 17:08:53 +0200 (CEST)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com
 [209.85.210.176])
 by mails.dpdk.org (Postfix) with ESMTP id 76FEE400D7
 for <dev@dpdk.org>; Fri, 17 Oct 2025 17:08:52 +0200 (CEST)
Received: by mail-pf1-f176.google.com with SMTP id
 d2e1a72fcca58-781001e3846so1970367b3a.2
 for <dev@dpdk.org>; Fri, 17 Oct 2025 08:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1760713731;
 x=1761318531; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4QFm+svXGFwyEdvruDwhFN0LiJL+1OUZVVy4+FdOeGQ=;
 b=XLKcIrab5xCQMmOGzr/Bdi9ytVM+pdmMsX1AYIAEfrTeCB1QuX0DLbn0SE62dqIpyR
 CpVPwS7H3Oe25FN+q3JbQzDNEuaHYHXp7KhLx3pZPYEBmxq6loBMnmoVeq4fpY3QA9HZ
 Zns0p0YA9wkdfjGSDJsCF2F1MJyiq7luIzG28rqeRzrFkICDgAQtqMehmO5Vv0kPEXac
 S2YXzL55l/SfIAN8G7FTm31B1YZWvaIrnHBuKExg8JBkQc/AoBYfH9yeWgTLt4nIRaWn
 kxfdlR8RMwkaUL9cpNOyjyJ3gl6vjmuWoQlI8NCBsf42PdTs9Fcm40NcuXGvPuOFv63/
 OqpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760713731; x=1761318531;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4QFm+svXGFwyEdvruDwhFN0LiJL+1OUZVVy4+FdOeGQ=;
 b=WVZhYxdDnWzVg9LUYLtGS8BVVswX0JH+/m7wQMbNzrHKImopy4/vdCnLmh0J9JPds0
 59TPBWw/HEwp3K/nukJzOTeLWL1Dwa/HjIrFqTT10tYaueMhMfR1pcDsLoNHIWuPfjWg
 sF+CN3RDpXSIhIKhX8WHcQGHjV9KuqXhelZ7BUvmH/0mJ6qVmhsMOpz9KvU0W6dZsRnh
 or6Z3SBSsA/CgPvt/pUt8yaCEH17u1KXp9+LdwXrEVL7/17zpxJM5vu9H/Jgh+DVlhAJ
 CntEpjZhyKNDS+Ot0oIYQF+6tD9/iTAplC3w61SxVIZ8AhC4zrdE3WfrutnWqVF43uY0
 n/kQ==
X-Gm-Message-State: AOJu0YxgZvr9ep/yzV/xMGgS5mhYqA5rBFvIn8HL9iWCdayg/W2Dw2/c
 odViwA/ButEfQ4x/RpMrvn22/T+yBiItlmQYYvwaebQzLhS5LnlPjBlOucIXSF9ssJ0HKdkWwwK
 HNXc0Yls=
X-Gm-Gg: ASbGncuYHwoEFkodHknCht/e3xr5M5s24wYQLm2cxDzkb0OzR4RA86ems2NJ2hxxLWq
 9zdtntMeYUjJf06eoXLMscjDJJWf7nKGrPQTVq68IYLtcDKJkC5gP7jxXWwuoJA+OU7sKcALUva
 rG7+/h4XXvzsb3VL/ZyS24UsFLFTTpGIOeMEotx3MbMz24t1ronlXyXpNlL3yvTBk065Yx69Rf0
 F3ob1aObz83BrJ3g/DmrgFvD/Kg8BRzLdb/z8fFzXbXOElP88M4O1EtTlleGQkTsZGGp8UfalNL
 r/SRYvqfSsvDHluOK9DAQgnS6hHYQsGDw5h5z5SZ4GrNnMhByKamURqRp/Czxn6xR9z7V1+dmf8
 ziXl5ImAEETpSN3wIz1bDrXoAeSSBylf/a9HlQWY7hCHNonDDlSwFDw2hUn0lzhEpWLK0ovgLvO
 vgaQJB+Td+8mcqFcuOPEPJh/Jv/ZejgOLWwnEYB9d82uVeqgdg7bhmMOzx1dFkUAQ=
X-Google-Smtp-Source: AGHT+IGyHdZGT6twlhi4wpIwMikaSf7gbyzZMwhBaaILAuzZ7zGrst5AVyy7uyzXONmkC21cNVHzxw==
X-Received: by 2002:a05:6a00:2e1f:b0:781:24ec:c8fa with SMTP id
 d2e1a72fcca58-7a220b2af8amr4783890b3a.27.1760713731421; 
 Fri, 17 Oct 2025 08:08:51 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7992bc13543sm26057464b3a.35.2025.10.17.08.08.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Oct 2025 08:08:51 -0700 (PDT)
Date: Fri, 17 Oct 2025 08:08:48 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH 0/2] format telemetry scripts using black
Message-ID: <20251017080848.4fa7e3ad@hermes.local>
In-Reply-To: <20251017135622.1152341-1-bruce.richardson@intel.com>
References: <20251017135622.1152341-1-bruce.richardson@intel.com>
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

On Fri, 17 Oct 2025 14:56:20 +0100
Bruce Richardson <bruce.richardson@intel.com> wrote:

> Run "black" tool on the dpdk-telemetry scripts to enforce coding style for python scripts.
> 
> Bruce Richardson (2):
>   usertools/dpdk-telemetry: correct script formatting
>   usertools/dpdk-telemetry-client: correct script formatting
> 
>  usertools/dpdk-telemetry-client.py | 49 +++++++++-------
>  usertools/dpdk-telemetry.py        | 90 +++++++++++++++++-------------
>  2 files changed, 79 insertions(+), 60 deletions(-)
> 
> --
> 2.48.1
> 

Looks good
Series-Acked-by: Stephen Hemminger <stephen@networkplumber.org>
