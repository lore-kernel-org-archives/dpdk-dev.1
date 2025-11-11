Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E88F6CCFA18
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Nov 2025 14:31:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 033B840613;
	Tue, 11 Nov 2025 15:31:52 +0100 (CET)
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by mails.dpdk.org (Postfix) with ESMTP id 2C18B4060F
 for <dev@dpdk.org>; Tue, 11 Nov 2025 15:31:50 +0100 (CET)
Received: by mail-pg1-f171.google.com with SMTP id
 41be03b00d2f7-b6271ea3a6fso2738066a12.0
 for <dev@dpdk.org>; Tue, 11 Nov 2025 06:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762871509;
 x=1763476309; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yGR0PHYsXWPGFxon/5KzZ2/bezGkdIJSTbEMiIms+k0=;
 b=w9VM8FooRjtjvl+OWSeMGnJGtsObQVZMOHG82C8DoLw+HydAu7T6wFdoiQ+SjwMdsE
 k0w/9AgYUHH03VObPyLc54eyTzTmNEeLhB/yTSw+aoFK7Agf7bUzFqc+WpQpt5/MqchR
 X7hwU8vwdvCkGghl2SPoYsq6+qtPT7Z0yIg1ny9m4AWuiy5rK6e0k1gQlCYFXLdlZqKz
 CvEi/m/JcgGkjy+607CLg3HFSeVcnOrUWAsRBAL4SXbJ4ED36LiIPzqiw+EQSdQFATiO
 h2ReAu5JePWaQmgdklZ+NKKOOlWThy/POFTkviv6NYaxZIPLDjCfdTNShLQOsZTz3ak8
 4sMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762871509; x=1763476309;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yGR0PHYsXWPGFxon/5KzZ2/bezGkdIJSTbEMiIms+k0=;
 b=Eed7yXxXu8rvLZ8N9dVG9y6i9WXkj8Qe68vfSZzxuvtcYLBFiHCxvOWH+b4RDVWFsK
 2/nhFQq9YQjAN71Gu2Lug0YNkxXBF5VFvxjFu/XCznP2A0ralth8hD05dx3wg2kIg6rE
 lHvsY1HhyFvEQjw3I481zRXSqtbZKWihv2c7YnsxiNbE5Gwh7FtrydJxgeIr76pmAMvp
 WHJiksEoYx+o7lDa8oMkDT2ZCvLbgcTUT8UquU7qPeCQ2S+e/Hms/ef+Op+z0KhnvZTq
 eket78aKLDHKShWNyoZY03lW+/E2L8H6fywikEWeQedvPWNHannJcHHj784hc1dYOxU4
 RNmg==
X-Gm-Message-State: AOJu0YzMXF2gO4RWDB0usc5c6gfQmWF438XRmArALP/D67EZAXcAyF4b
 bWOVcPjbO1lmhVvodY1jhdXPYsoZxxGdNxbMErLb2AEUmgfzzZH2pkPtbI+0vkKnvBbAKXmfOHT
 ec++H
X-Gm-Gg: ASbGncuvBUkTbENtiPkqZli7rTZJ/KLOKeJNNY9Cg1HqU6BR/0AmnSvK4sd+n9EsLnK
 PUw22tS0UshuQPVgTyQVWOdFjJ+99bETxG6A5CHK5uJLPWXSK4w0pFU237piEK7vNzrzhPB7dE5
 eKHM6vWF8qhXIraOgdsvegUJXlCxanF3zWg40ovdrV91zi/68DBhIJv0TPXgf6XqmQyWwR6ljtu
 wBu+s63yZT6HqWwva18Dm5Owjd2WeBE1fVzdSQHwNIFvebfKjL1lHKLz3jmdWBp1HLTPOa6cF0Q
 EwdWpIrnD7QsAiVmcBxs7n/mtINHPxTbEvdj1xaVs2lZLm+INdaBEavqE7sDx93CzDFg5sigEGA
 mI7cLHJLSQjapjiDvXsSLUkLTAgovIZ2mu27sPdVBCTQ9Qh3dFQqEa6AsgHMORKUY65KCiPpJQt
 5/VNYAzMHiafRGGrCW/1H6HJIyvjJAyZ0hKA==
X-Google-Smtp-Source: AGHT+IGaqpwsDnm9Rek3iXBY0rBd8u89gv6WPouYPJ/NhYascQBXBZrY8iPn0rDE7zhWe0A36wxJ1Q==
X-Received: by 2002:a17:902:e888:b0:295:96bc:868c with SMTP id
 d9443c01a7336-297e5412cc8mr145474865ad.5.1762871508788; 
 Tue, 11 Nov 2025 06:31:48 -0800 (PST)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-297d6859a92sm136219175ad.88.2025.11.11.06.31.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Nov 2025 06:31:48 -0800 (PST)
Date: Tue, 11 Nov 2025 06:31:41 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dimon Zhao <dimon.zhao@nebula-matrix.com>
Cc: dev@dpdk.org, Kyo Liu <kyo.liu@nebula-matrix.com>, Leon Yu
 <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>
Subject: Re: [PATCH v1 1/1] net/nbl: fix issues reported by Coverity
Message-ID: <20251111063141.4611949d@phoenix>
In-Reply-To: <20251030033619.3386064-2-dimon.zhao@nebula-matrix.com>
References: <20250627014022.4019625-1-dimon.zhao@nebula-matrix.com>
 <20251030033619.3386064-1-dimon.zhao@nebula-matrix.com>
 <20251030033619.3386064-2-dimon.zhao@nebula-matrix.com>
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

On Wed, 29 Oct 2025 20:36:19 -0700
Dimon Zhao <dimon.zhao@nebula-matrix.com> wrote:

> Coverity issue: 490942
> Coverity issue: 490943
> Coverity issue: 490946
> Coverity issue: 490947
> Coverity issue: 490949
> Coverity issue: 490950
> Coverity issue: 490951
> Coverity issue: 490952
> Coverity issue: 490953
> Coverity issue: 490954
> Coverity issue: 490955
> Coverity issue: 490957
> Coverity issue: 490958
> Coverity issue: 490959
> Fixes: a1c5ffa13b2c ("net/nbl: add channel layer")
> Fixes: dc955cd24c8f ("net/nbl: add coexistence mode")
> Fixes: 93b38df5a2ec ("net/nbl: support basic configuration")
> 
> Signed-off-by: Dimon Zhao <dimon.zhao@nebula-matrix.com>
> ---

Queued to next-net

