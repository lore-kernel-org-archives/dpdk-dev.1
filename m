Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A615C83F26
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Jul 2025 04:24:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BF1AC40668;
	Tue, 29 Jul 2025 06:24:27 +0200 (CEST)
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com
 [209.85.219.51]) by mails.dpdk.org (Postfix) with ESMTP id 0E11840647
 for <dev@dpdk.org>; Tue, 29 Jul 2025 06:24:26 +0200 (CEST)
Received: by mail-qv1-f51.google.com with SMTP id
 6a1803df08f44-704c5464aecso48899316d6.0
 for <dev@dpdk.org>; Mon, 28 Jul 2025 21:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1753763065;
 x=1754367865; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iPvGV7lb/62iVKGmDHUgurXw2nnF/ebtNpJe6r9HMDI=;
 b=tqTXTIUCFR6oUqegTZZXEHDq+WfW7oLd7yI5EacekPDMrgQcApKIx8huV+onI2hl4g
 ds4WBJbqE3VRGYmNz453p4e1QbKvxe85TH7f/V21mzsrNmoKaCJFaDgfBhZqvJpNlp0a
 Ho/jy4O68vJmZSbAal5+zMLDjvQhsTgipN4PCMcap0tQLmGG1WVPmhUTPjzPmtSDh3A3
 wxwDJ5kghkfpixHBGQY2pdEInMpEbFwApHn0enVhkwoayfsGONEF9qtVxD6kpJO1nqCX
 SY4h/QxBhCnnju0xt2SiZQiCoXrgYhH1YwAqY8eWf287F5Ft+UFX5fkhU0oOTpuQX/fj
 yIyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753763065; x=1754367865;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iPvGV7lb/62iVKGmDHUgurXw2nnF/ebtNpJe6r9HMDI=;
 b=LpqKX0uWI5JLcGXugp00LVDXfsGBvCKUpzGSG8I8QN9Fixy5ChzBxXPq506h6DljD2
 ZVNIeWjd9WWgprcaWCKnv/k49zknduTrvw0k+TRGV+rMCCeEc5GLninyuMKv37wgC9PP
 HZcmhuzS7Oufk3hN/uEvWv+8k8DtCVPQsL9+jXR6u4abYOHp8bHh1hxgBn8cxJJ/Zz4L
 JFfKQVp5dZmJO2UBB4b10C9/nvc9yA8aMqqp08oUjvSFdiQ7u/GaDIWaiOxsd9aIiH7+
 145MgFRy8cxRkSu44x/X8PqXgwBof1abk7Ho3uqqoaNSKm6Z7KkqcjuCWYZMixUBu78r
 wbCA==
X-Gm-Message-State: AOJu0YzoA/otgtO51Ebuy9ThA/p6hcxd+0DauAyjRYZ8B3cWvE48pxfV
 dx8YPqb0Tl20e7SRPFwHUtBF/TA9iSXDC8dwF22ilGiYnJ1ux5iSx5F7wLSetJMpV32vJL+VUHE
 Pek8A
X-Gm-Gg: ASbGnctG5eQZ7fwj2UJNIlvRAaLMkQ9MUIccxKm2BQlnQar0KQ2XmtZyWtwNWHWbdra
 5nR83+grk7pS26BfcXq0wLnk65FSS+ZJBrcC23+0eEojVnkrqBhInK1oxdiX30p99fdSOq3ITT1
 iuAoXUel6T6UZDgFKDtUuijaDooNNwZ8/d1Xh4HVvsXKYBp+mu8fg0APMsqqA6ZrSdDWcHBICNx
 lyPCh1Ewi3MYUxGRjpsO9xPg2P/F2YQ9R+r+W/L6B173OC+5N+gYYfCfc7yS17dtCrHxZndKaJV
 nW3O3kcD2R99tuQLLvktTdcRNOPPKtKUnsefQR4I7p4qFw04e6E2EchacRyExkvU1/T6xJQx84U
 ygrw90UTaeExbWj8d5YQ5R9us8gwDkwJ1c6SqGE31UtzQwVmGBiz5sO6cyzfXFtDUZGQCvk1P5z
 g=
X-Google-Smtp-Source: AGHT+IHURoudJrQcgSS3ftYifGsEzBn96YRh7UgfjMhfFH5hKsy6CGXQ8Acfm2WniqmSkX0Wzfy1iw==
X-Received: by 2002:ad4:5d47:0:b0:6fb:3579:8f07 with SMTP id
 6a1803df08f44-707205aeb62mr228102536d6.31.1753763065386; 
 Mon, 28 Jul 2025 21:24:25 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-70729c880b6sm39468556d6.91.2025.07.28.21.24.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Jul 2025 21:24:25 -0700 (PDT)
Date: Mon, 28 Jul 2025 21:24:22 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v3 3/3] app/testpmd: improve output when processing
 cmdline files
Message-ID: <20250728212422.2c86915c@hermes.local>
In-Reply-To: <20250707111751.183469-4-bruce.richardson@intel.com>
References: <20250704140551.4151993-1-bruce.richardson@intel.com>
 <20250707111751.183469-1-bruce.richardson@intel.com>
 <20250707111751.183469-4-bruce.richardson@intel.com>
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

On Mon,  7 Jul 2025 12:17:51 +0100
Bruce Richardson <bruce.richardson@intel.com> wrote:

> Two small improvements for the cmdline file processing in testpmd.
> 
> * Now that we support multiple files, change the prompt to indicate what
>   file is currently being processed, and just print an EOF message when
>   done.
> * When not echoing, the "Read" verb in the message "Read CLI commands..."
>   is a little ambiguous, as it could mean "I have read", or "Go and read",
>   i.e. job done or job about to start. Tweak the text to "Finished reading"
>   which is unambiguous.
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
> 
> Owing to limitations of whats available on windows, e.g. no basename
> function, the windows implementation prints N characters from the end of
> the filename, if its too long. While I don't think this is as good as the
> basename version used on Linux/Unix, if we want to have common code, we can
> just use that as a common version everywhere and drop the basename version.

I would prefer just having basename() wrapper like other helpers
we have already for Windows. Get from FreeBSD or other BSD licensed source
(or write your own).

Having two #ifdefs creates needless platform difference here.
