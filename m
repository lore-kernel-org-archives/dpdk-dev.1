Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C395DCD13DA
	for <dpdk-dev@archiver.kernel.org>; Fri,  1 May 2026 03:05:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C8C6E4027D;
	Fri,  1 May 2026 05:05:20 +0200 (CEST)
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com
 [209.85.167.176])
 by mails.dpdk.org (Postfix) with ESMTP id 2A8554026D
 for <dev@dpdk.org>; Fri,  1 May 2026 05:05:19 +0200 (CEST)
Received: by mail-oi1-f176.google.com with SMTP id
 5614622812f47-47c7b282d73so74129b6e.3
 for <dev@dpdk.org>; Thu, 30 Apr 2026 20:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1777604718;
 x=1778209518; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=90gqfT9OGTstbjKXEw10ErUb3aqlRBRaTCAqzXtlp2M=;
 b=LieqC8TTBZKaklfrMnHs/lWkDjhhgZT5h77Vg1YYLe8iYgz2rkx0VJ1QJpE8e4001T
 hsj9FD3zX+WbhVCgtdlVMgrHlaS1Rtg+pwtaNlXHZxte02ig3UXoi4F9aO1U3C7kUCQR
 vgFowbG0NsIPwCrH0BQJYCmIgk4YKadieHcVKDvxSmsRLD7GA86OMwB+5t5N3VGo0HkZ
 aHt6y1qjLejSXBXXXlArWbtf7aHNAukLcuasfxI1MJhNdcnhPqKWSHbJMVYXYpXd+Dsw
 kaw6GZilaReMKUGWfyvT4y2Iqw5gH8MX9mmkqvYpbU4Rpv4TFtWcqI5EFIbgAVcbdp1B
 kvog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777604718; x=1778209518;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=90gqfT9OGTstbjKXEw10ErUb3aqlRBRaTCAqzXtlp2M=;
 b=ZfRB1ByS5KGv40MFcXN300pBej36V816wxB26kmhRoSLH+q6f08cLNm2bQS7WwQ4RI
 fCxr2tPv8WBp3oXMhQTcnS8nO/rlswanq65sJUegrJ0FZfTCn/Py+RU0/v0oYtESGnv3
 rTiL6qH5h2ERwA31EsY100SoWvGfBzFNOWaynPu3kISZW3h9tzJrlUHasJhf34g/RyiF
 JO/tChn8ZyXHO0Mw+7Bd4HM0KgnmeUdeC1H4OEbldAmI5cR7rwJ8ligYnB2tpiVKnYav
 HibDBH1KzdvRl1F6e7PYJ9AWJkm/Ir+5DW0nzpSgAoGxJLHxLaT1mhZ9teuijYCnAN5s
 5dqw==
X-Gm-Message-State: AOJu0YwO3YkJfyZ4XgcH1opKUWwamiiduGRHm243Z35GCmDCr5qn5Bs0
 OCT+6qCua1vb7pCxPpkrDiET5VfS5KoxGkOSx3Jb49r0MCqJ7EK0GEHKVZn9KTaslb6CwKQy4iS
 9gLlg
X-Gm-Gg: AeBDieuqfutZ/4ieX3EJE0SOA8lJOT3+8q37QYuin0BU8U9NE8ofXrgKYNsnPoHBOhM
 f+q72IbVMWwbKYHhNW2vfZxgvDejoS28KC8IMxKCQyuOTjbuszqcHOglXdiICz/k87XVEMhbsVW
 9+bUse/b3TKcK0a4+jv5ltStwT69fpjnzTk0y06lncvUCZBDyUCT2zP4Ldr2SlZaIHBqrgjlEBF
 1PVzY6odwNHvYYil1Xzl7FDpF33YOCG/smfoEAGpiAUNHmaVGvgd9sS6wwWwH+fHhMBxfi/Rp28
 l+e37unOZBvPhO6FJo/gyuvXlqsyY3NkGO0go88V+GA69QNpwYJCm1RX1/EsM5XV+dMp5sCCghm
 V6AOu6eSgatTgxCSDvKx/Ugzp0icBgXw3LykL1vZtR9WgFQZ0DDZQ9BCVztiFOW2+MqmiqZAPXO
 tlzao7k1SpA5NJmpCKt6cFFV6qrO2iXr3B9GL7yOeBDRnv5zoX9gvTeyR9
X-Received: by 2002:a05:6808:2008:20b0:47b:c782:1214 with SMTP id
 5614622812f47-47c75730cc8mr415205b6e.37.1777604718000; 
 Thu, 30 Apr 2026 20:05:18 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-47c763b33c1sm597923b6e.1.2026.04.30.20.05.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 20:05:17 -0700 (PDT)
Date: Thu, 30 Apr 2026 20:05:14 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: liujie5@linkdatatechnology.com
Cc: dev@dpdk.org
Subject: Re: [PATCH v4 3/9] drivers: add sxe2 basic structures
Message-ID: <20260430200514.0053998c@phoenix.local>
In-Reply-To: <20260501015925.263486-4-liujie5@linkdatatechnology.com>
References: <20260430101819.4094628-10-liujie5@linkdatatechnology.com>
 <20260501015925.263486-1-liujie5@linkdatatechnology.com>
 <20260501015925.263486-4-liujie5@linkdatatechnology.com>
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

On Fri,  1 May 2026 09:59:18 +0800
liujie5@linkdatatechnology.com wrote:

> From: Jie Liu <liujie5@linkdatatechnology.com>
> 
> This patch adds the base infrastructure for the sxe2 common
> library. It includes the mandatory OS abstraction layer (OSAL),
> common structure definitions, error codes, and the logging
> system implementation.
> 
> Specifically, this commit:
>  - Implements the logging stream management using RTE_LOG_LINE.
>  - Defines device-specific error codes and status registers.
>  - Adds the initial meson build configuration for the common library.
> 
> Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
> ---
NAK.


NAK.

DPDK drivers must not reinvent their own logging, and they absolutely
must not hijack the log stream that is shared with the application and
the rest of DPDK. This patch does both.

Concrete problems in what you posted:

1. PMD_LOG_NOTICE/WARN/ERR/CRIT/ALERT/EMERG call
   rte_openlog_stream(g_sxe2_common_log_fp) before logging and
   rte_openlog_stream(NULL) after. rte_openlog_stream() sets the
   *global* DPDK log stream for the entire application. A driver has
   no business deciding where the application's logs go. As written,
   this will silently redirect every other PMD's, every library's,
   and the application's own output any time sxe2 emits a message.

2. Those same macros emit the message twice -- once before the stream
   is swapped and once after -- so every NOTICE/WARN/ERR comes out
   duplicated.

3. Drivers must not open files. fopen("/var/log/sxe2pmd.log.<ts>",
   "w+") from inside a PMD is a security problem on every level:

   - It runs with whatever privileges the application has, which for
     DPDK is typically root or CAP_*-loaded. Creating files in
     /var/log under those privileges is a classic symlink / TOCTOU
     attack surface.
   - The path is attacker-influenceable in the timestamp component
     and is not created with O_CREAT|O_EXCL, no mode argument, no
     directory fd, none of the hardening you would expect.
   - Log content is written without any escaping; anything an
     attacker can get into a log message ends up in a file the
     operator will later cat or grep.
   - It bypasses whatever logging policy the operator, distro,
     systemd unit, container runtime, SELinux/AppArmor profile, or
     application has configured. A driver silently writing to
     /var/log is exactly the kind of thing those policies exist to
     prevent.
   - It doesn't work for non-root users, in unprivileged containers,
     on read-only rootfs systems, or on Windows.

   Drivers log through rte_log. The application decides where those
   logs go. Full stop.

4. RTE_LOG_REGISTER_SUFFIX(..., com, DEBUG) defaults the log type to
   DEBUG. The default level is the application's choice, not the
   driver's.

5. SXE2_DPDK_DEBUG is unconditionally defined in
   drivers/common/sxe2/meson.build, so the "debug" path with the file
   hijacking is always on. There is no off switch.

6. SXE2_PMD_LOG adds a thread id, basename, line number, and function
   name to every line. If those are useful, they are useful for every
   driver -- not just yours.

General principles, which apply to every driver:

- Drivers do not reinvent logging. Use RTE_LOG / RTE_LOG_LINE and a
  log type registered for the driver. That is it.
- Drivers do not open files, and do not change logging behavior that
  is shared with the application or with other drivers. Both have
  security implications well beyond this driver.
- If something is genuinely missing from the common logging
  infrastructure -- per-driver log files, richer prefixes, thread
  ids, structured fields, whatever -- propose it as a change to
  lib/log so every driver and every application benefits, and so it
  gets reviewed for security by people who do that for a living. Do
  not bury it inside one driver.
- "It works for our embedded use case" is not an argument. DPDK runs
  on Linux, FreeBSD, and Windows; on x86, Arm, POWER, and RISC-V; in
  bare metal, VMs, and containers; as root and as unprivileged users.
  A driver has to behave reasonably in all of those.
- Once we make an exception for one driver, every subsystem will
  expect one. That is not happening.

Please drop sxe2_common_log.c and sxe2_common_log.h entirely. Use the
existing RTE_LOG_* macros directly against a log type registered for
your driver, and respect the level and stream that the application
has configured.

While you're at it, the same "this driver is a special snowflake"
pattern shows up elsewhere in this series and gets the same answer:

- sxe2_type.h redefines u8/u16/u32/u64/s8/.../__le16/__be32 instead
  of using uintN_t and rte_beN_t.
- sxe2_errno.h reinvents errno values that already exist.
- sxe2_osal.h re-implements bitmap operations, allocation wrappers,
  and an OS abstraction layer that DPDK already provides.

This is the cost of being part of a shared community project across
many platforms and architectures. Please rework on that basis before
reposting.

Stephen

PS: AI revised this text, my initial version was probably
not safe for public consumption.
