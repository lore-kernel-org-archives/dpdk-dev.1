Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B496FCA1012
	for <dpdk-dev@archiver.kernel.org>; Sat,  6 Sep 2025 04:12:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CA841402AF;
	Sat,  6 Sep 2025 06:12:04 +0200 (CEST)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45]) by mails.dpdk.org (Postfix) with ESMTP id 8698040156
 for <dev@dpdk.org>; Sat,  6 Sep 2025 06:12:03 +0200 (CEST)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-45dd505a1dfso13595515e9.2
 for <dev@dpdk.org>; Fri, 05 Sep 2025 21:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1757131923;
 x=1757736723; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pGfBh9sKLZkcKzaB4piYAMvvlwMwjHgJwqnZhOmEOyo=;
 b=uQyF+JMESXxemKeL2M5uJjjCR6q2PhqycaVN6CbQUAp7v/iC/SCpbskgk1FzBbo2au
 I7Z4qs89AAtuEGXGoRJgXCBGh2rXe1yGmPQYNVEmoFiKwBcRb0meiqPE+P/BxJVfru61
 j+Bs9HVlq9JWk+xwbPtmNuC7gZBJs2IpGhVTKZxW4KnJC3QY7MYMyQY+JGYJ9Jzzp2lI
 BzGEpsEeUj0VIPwwyd91Krsbk1GkSQlH+JwMLIKvuy6gzAvmcYFDucxO5gFZnW8YAXXV
 VhM2nJIB9Dyn2xQqLGfOKG2VeXY7+RnN2dOBh7fWUmktFbWEFX4kCrZ+K1Hd4ytolDwV
 +yhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757131923; x=1757736723;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pGfBh9sKLZkcKzaB4piYAMvvlwMwjHgJwqnZhOmEOyo=;
 b=HfbQf8p5zQhwzPcAU0Yu8hvKpQa4k/uOIyjtLjFSl98XZs+2wh+fe2O/5D9uADQf9d
 wnRldtg66kHoV8SHwo8mipf1//aG7arAT81bl7GljBzNmUPgjgGqzqukUn6Fu3Mvg/lN
 cid3cOxD6Qtt3pTTgzrac/TIdSVcZjO/XPTsaWI88EMtWfnTZqQ9N+nl77ZARfKjmPip
 +AL5OAkGjX+N3+UJF8c3lF8TNcQioo9rDmVnB+qnUznuUH84LavHPGELdG15qwH4gsMm
 1z54xK+vj9q22zkRgP1tdAS9YFPKOl4POS1cIvgOAWnvPlXBgQjrVzmxxaKs+SdYLhep
 QKbg==
X-Gm-Message-State: AOJu0Yxc/M64uBK5ZufapXkL07nikghVlOCZKx1xY0coo86I2dkeAnMI
 uX4DGL9e/T8BnxetdvKJ6gvvkvNLElBcuyl7m7Swj0y4nzPitpI6gfEqZ2+igM7Rmhs=
X-Gm-Gg: ASbGncu3oU1PUfVW3fd38qp8wz9iLSQDpgy3RGmzAUr/D198bC7JO53ySjb8HS2GrWh
 oRPixmYHWmmE5LNQrDSb1iNVAHXr+BY/4LqYkQ+gBb41EKXQOpSv+tmafhNislsYvA3rk3x4oyF
 r7uukH8+2rA9IUaZIeyiDuaOqPm46US6U2UBKM/vDPmqVERhqJ2LTgaJtp1/+zxUDhZ7YybVVkJ
 Kzv/8NkqxYNhCfgi8z4dLGNMGgMEaUeYiD9B6KF4Uu0SZWIoMkskAtaYkQzDghqIgovfhjPM/s2
 rkYkmuUV0gVN7R3kaP/t6iXTmzgXQJ+lyRpf9J0FbmwOlWsfyRoReSRY80TxjnLkj9GFV5eWUmp
 wJTOYk7RdN1oSvS0JuCI9sZil5Lz42ZOlqwMabfE7rLoTkqe5JQKTLI9UkZ+njpHRZlQnPocxxv
 cIlol3+ATD1Q==
X-Google-Smtp-Source: AGHT+IEejIo/6bsswyHoCSwKITJsDFBpRSipp7kvUCTuS8ipNh++E8GnvZmmsUNGo09hy2NSvqWyfg==
X-Received: by 2002:a05:600c:a44:b0:45b:7ce0:fb8a with SMTP id
 5b1f17b1804b1-45dddee3c05mr6035545e9.35.1757131922847; 
 Fri, 05 Sep 2025 21:12:02 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b6f0d32a2sm476020505e9.9.2025.09.05.21.12.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Sep 2025 21:12:02 -0700 (PDT)
Date: Fri, 5 Sep 2025 21:11:57 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, thomas@monjalon.net, maxime.coquelin@redhat.com,
 anatoly.burakov@intel.com
Subject: Re: [RFC v2 8/9] uapi: import VFIO header
Message-ID: <20250905211157.00ab0e5a@hermes.local>
In-Reply-To: <20250903151800.1965006-9-david.marchand@redhat.com>
References: <20250903072826.1727004-1-david.marchand@redhat.com>
 <20250903151800.1965006-1-david.marchand@redhat.com>
 <20250903151800.1965006-9-david.marchand@redhat.com>
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

On Wed,  3 Sep 2025 17:17:58 +0200
David Marchand <david.marchand@redhat.com> wrote:

> Import VFIO header (from v6.16) to be included in many parts of DPDK.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
>  kernel/linux/uapi/linux/vfio.h | 1836 ++++++++++++++++++++++++++++++++
>  kernel/linux/uapi/version      |    2 +-
>  2 files changed, 1837 insertions(+), 1 deletion(-)
>  create mode 100644 kernel/linux/uapi/linux/vfio.h

The linux kernel source tree has a well defined method for making exported
uapi headers: 
	make headers_install

DPDK should not be inventing its own method for this.

If you use this on current released kernel (6.16) you will get slightly different file.
The point of having DPDK vfio.h was to workaround case where distro was too old;
not to be different.

diff --git a/kernel/linux/uapi/linux/vfio.h b/kernel/linux/uapi/linux/vfio.h
index 4413783940..4d96d1fc12 100644
--- a/kernel/linux/uapi/linux/vfio.h
+++ b/kernel/linux/uapi/linux/vfio.h
@@ -9,8 +9,8 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-#ifndef _UAPIVFIO_H
-#define _UAPIVFIO_H
+#ifndef VFIO_H
+#define VFIO_H
 
 #include <linux/types.h>
 #include <linux/ioctl.h>
@@ -905,10 +905,12 @@ struct vfio_device_feature {
  * VFIO_DEVICE_BIND_IOMMUFD - _IOR(VFIO_TYPE, VFIO_BASE + 18,
  *				   struct vfio_device_bind_iommufd)
  * @argsz:	 User filled size of this data.
- * @flags:	 Must be 0.
+ * @flags:	 Must be 0 or a bit flags of VFIO_DEVICE_BIND_*
  * @iommufd:	 iommufd to bind.
  * @out_devid:	 The device id generated by this bind. devid is a handle for
  *		 this device/iommufd bond and can be used in IOMMUFD commands.
+ * @token_uuid_ptr: Valid if VFIO_DEVICE_BIND_FLAG_TOKEN. Points to a 16 byte
+ *                  UUID in the same format as VFIO_DEVICE_FEATURE_PCI_VF_TOKEN.
  *
  * Bind a vfio_device to the specified iommufd.
  *
@@ -917,13 +919,21 @@ struct vfio_device_feature {
  *
  * Unbind is automatically conducted when device fd is closed.
  *
+ * A token is sometimes required to open the device, unless this is known to be
+ * needed VFIO_DEVICE_BIND_FLAG_TOKEN should not be set and token_uuid_ptr is
+ * ignored. The only case today is a PF/VF relationship where the VF bind must
+ * be provided the same token as VFIO_DEVICE_FEATURE_PCI_VF_TOKEN provided to
+ * the PF.
+ *
  * Return: 0 on success, -errno on failure.
  */
 struct vfio_device_bind_iommufd {
 	__u32		argsz;
 	__u32		flags;
+#define VFIO_DEVICE_BIND_FLAG_TOKEN (1 << 0)
 	__s32		iommufd;
 	__u32		out_devid;
+	__aligned_u64	token_uuid_ptr;
 };
 
 #define VFIO_DEVICE_BIND_IOMMUFD	_IO(VFIO_TYPE, VFIO_BASE + 18)
@@ -1833,4 +1843,4 @@ struct vfio_iommu_spapr_tce_remove {
 
 /* ***************************************************************** */
 
-#endif /* _UAPIVFIO_H */
+#endif /* VFIO_H */

