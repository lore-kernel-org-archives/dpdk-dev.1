Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF7D8CAC5BB
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Oct 2025 08:20:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 04C2440A7F;
	Wed,  1 Oct 2025 10:20:31 +0200 (CEST)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com
 [209.85.217.53]) by mails.dpdk.org (Postfix) with ESMTP id 7AE4D400EF
 for <dev@dpdk.org>; Wed,  1 Oct 2025 10:20:29 +0200 (CEST)
Received: by mail-vs1-f53.google.com with SMTP id
 ada2fe7eead31-58d377d786bso4682231137.1
 for <dev@dpdk.org>; Wed, 01 Oct 2025 01:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1759306829;
 x=1759911629; darn=dpdk.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=y2rv2UYqP0K3sODmJ98B7r0Dl4hWQehMky/shWhSQdU=;
 b=M03zZzy4Tesg5ZYv0urgeF+EbpBZYyPEDTZHC2xIWgyw4+99Psd7V9Nf59S5OPqWr/
 S6WFPZExv3Fopkjtc2AdQO5Dhv7LRnq/cv+bl5dVLFRMfNNet1FyWoTKKMKZNI+M0I50
 8apdImMzp6UZzA2l+d1nVl9ROYs+v/rlkdnGGOsT5/QjCvqgKc8+JjfwiQ8FgucOIEUk
 lgW+P0MQiUzNOJhy2I1nBiZ4+CMwDIfOaJqFmQ2ZZ5bcSzprq53+Cg3NYplgnALJhofD
 ucIqkFhYZ+cdrb8s72/46tL3VbCKVTe6f+p5RJTxrR3TxrBIfe6t5RJqO7eVvPSOGoBh
 6OiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759306829; x=1759911629;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=y2rv2UYqP0K3sODmJ98B7r0Dl4hWQehMky/shWhSQdU=;
 b=p27LUTo77+M7Wi+AJwKFBPuDh4PaJf/WYuQrmT/1GB0+y9Kxk6qKqG5f3cbuNNDHgK
 zLCtmff09X5MmCqa12PXokjcH2AKWwGcQjr2c+2HQtuDHBHFPJiQpvPlcClQq15RzFSu
 KkW65VLkEwL4rHvwlwP8BoI/u8DO0Ilom6MG3ycbHpXE0ANila3htr9yFqvVbfKa4oBi
 1jwMGJCvmxnRZXhP1DFFvELFTPxYfeK56ouoLZ+bdAaHuPz9L7tCSOx5A7+zDO3lCz2K
 RJPtLkaZyV38Ik5Ub3m6U4BmupL5Ok+6KdSVAjLQnQV7a/DuY5b9DbsMBiecR7LOesUA
 KJew==
X-Gm-Message-State: AOJu0YwzxLjbdn9krvXC26LBkDTBsWzu5Qi11DDhX5OqLpUYmj8mQDl0
 1ZMFl3IjK9Mzo5jHOh09IapyxiY2bq3NmcioLWPcIo7UoYtQ3+fg7ZuLR+39bYoNZxQm8qsqG5i
 sJJ+Cz5I6AeDS367RdsB+kxhfKd9MlPH+LIujBAsLhg==
X-Gm-Gg: ASbGncuTVB44PWYHQt1A+GNST3wJUKNfCUGddaeDDoJ50BDvpCfuaLM2p607gyWbgrF
 BoOQ+ms1+4LvkvfZE46Tewv0I3cvKPT70OmI65mSgam3LEDE5pz6vDrujZFclYD2yymbCBmn9az
 +KyJJwSdOF0vPXnMEH9hmzCw/r/YRAGwNGhCXVxJbzylD/i8mbJ+Vb81g+Tr2f60OhoF0m4M9HM
 rIwNJ2afVWf52QzxdLdBS9YP4UhfcI=
X-Google-Smtp-Source: AGHT+IEZnk6TejLjRXq63RdkpssWiu0hbgCYOfaLAda3F4EggQ5mfmDMEgnFNvrN87xGAH6U96mIpGW22P1patavTNE=
X-Received: by 2002:a05:6102:161e:b0:520:ec03:32e9 with SMTP id
 ada2fe7eead31-5d3fe4fa56emr1043055137.3.1759306828721; Wed, 01 Oct 2025
 01:20:28 -0700 (PDT)
MIME-Version: 1.0
References: <20250616072910.113042-1-shperetz@nvidia.com>
 <20250930233828.3999565-1-thomas@monjalon.net>
 <20250930233828.3999565-5-thomas@monjalon.net>
In-Reply-To: <20250930233828.3999565-5-thomas@monjalon.net>
From: Stephen Hemminger <stephen@networkplumber.org>
Date: Wed, 1 Oct 2025 10:20:18 +0200
X-Gm-Features: AS18NWBIaZ1kRul2uI3ag19zyxBIpstGK76lYHWwyyNMfrXEOaY2c4Zq92lOuSY
Message-ID: <CAOaVG15nZ7NpHQuYnWtiit+U5HbwncEZEuUWA_ZaPnE1doHvpg@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] app/testpmd: add commands to dump mbuf history
To: Thomas Monjalon <thomas@monjalon.net>
Cc: dev <dev@dpdk.org>, shperetz@nvidia.com, 
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bruce Richardson <bruce.richardson@intel.com>, 
 =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>, 
 Aman Singh <aman.deep.singh@intel.com>
Content-Type: multipart/alternative; boundary="00000000000093c0210640148a07"
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

--00000000000093c0210640148a07
Content-Type: text/plain; charset="UTF-8"

Most testpmd commands use spaces not underline as word separator.

On Wed, Oct 1, 2025, 01:39 Thomas Monjalon <thomas@monjalon.net> wrote:

> From: Shani Peretz <shperetz@nvidia.com>
>
> Dump the mbuf history to the console or to a file.
>
> The dump will contain:
> - Operation history for each mbuf
> - Summary and statistics about all mbufs
>
> Dump the history of all mbuf pools:
> testpmd> dump_mbuf_history_all
>
> Dump the history of one mbuf pool:
> testpmd> dump_mbuf_history_single_mempool <mempool_name> [file_name]
>
> Dump the history of one mbuf:
> testpmd> dump_mbuf_history_single
>
> Signed-off-by: Shani Peretz <shperetz@nvidia.com>
> ---
>  app/test-pmd/cmdline.c | 246 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 245 insertions(+), 1 deletion(-)
>
> diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c
> index 3731fba370..113db68f8c 100644
> --- a/app/test-pmd/cmdline.c
> +++ b/app/test-pmd/cmdline.c
> @@ -40,6 +40,7 @@
>  #include <rte_gro.h>
>  #endif
>  #include <rte_mbuf_dyn.h>
> +#include <rte_mbuf_history.h>
>  #include <rte_trace.h>
>
>  #include <cmdline_rdline.h>
> @@ -296,6 +297,15 @@ static void cmd_help_long_parsed(void *parsed_result,
>                         "dump_log_types\n"
>                         "    Dumps the log level for all the dpdk
> modules\n\n"
>
> +                       "dump_mbuf_history_all\n"
> +                       "    Dumps the mbuf history for all mempools\n\n"
> +
> +                       "dump_mbuf_history_single <mbuf_ptr>\n"
> +                       "    Dumps the history for a specific mbuf (use
> 0x<address> format)\n\n"
> +
> +                       "dump_mbuf_history_single_mempool <mempool_name>
> [file_name]\n"
> +                       "    Dumps the history for a specific mempool\n\n"
> +
>                         "show port (port_id) speed_lanes capabilities"
>                         "       Show speed lanes capabilities of a
> port.\n\n"
>                 );
> @@ -9177,6 +9187,8 @@ static void cmd_dump_parsed(void *parsed_result,
>  #endif
>         else if (!strcmp(res->dump, "dump_log_types"))
>                 rte_log_dump(stdout);
> +       else if (!strcmp(res->dump, "dump_mbuf_history_all"))
> +               rte_mbuf_history_dump_all(stdout);
>  }
>
>  static cmdline_parse_token_string_t cmd_dump_dump =
> @@ -9198,7 +9210,8 @@ cmd_dump_init(void)
>  #ifndef RTE_EXEC_ENV_WINDOWS
>                 "dump_trace#"
>  #endif
> -               "dump_log_types";
> +               "dump_log_types#"
> +               "dump_mbuf_history";
>  }
>
>  static cmdline_parse_inst_t cmd_dump = {
> @@ -9260,6 +9273,232 @@ static cmdline_parse_inst_t cmd_dump_one = {
>         },
>  };
>
> +/* Dump mbuf history to file */
> +struct cmd_dump_mbuf_to_file_result {
> +       cmdline_fixed_string_t dump;
> +       cmdline_fixed_string_t file;
> +};
> +
> +static void cmd_dump_mbuf_to_file_parsed(void *parsed_result,
> +               struct cmdline *cl, __rte_unused void *data)
> +{
> +       struct cmd_dump_mbuf_to_file_result *res = parsed_result;
> +       FILE *file = stdout;
> +       char *file_name = res->file;
> +
> +       if (strcmp(res->dump, "dump_mbuf_history_all")) {
> +               cmdline_printf(cl, "Invalid dump type\n");
> +               return;
> +       }
> +
> +       if (file_name && strlen(file_name)) {
> +               file = fopen(file_name, "w");
> +               if (!file) {
> +                       rte_mbuf_history_dump_all(stdout);
> +                       return;
> +               }
> +       }
> +       rte_mbuf_history_dump_all(file);
> +       printf("Flow dump finished\n");
> +       if (file_name && strlen(file_name))
> +               fclose(file);
> +}
> +
> +static cmdline_parse_token_string_t cmd_dump_mbuf_to_file_dump =
> +       TOKEN_STRING_INITIALIZER(struct cmd_dump_mbuf_to_file_result, dump,
> +                       "dump_mbuf_history_all");
> +
> +static cmdline_parse_token_string_t cmd_dump_mbuf_to_file_file =
> +       TOKEN_STRING_INITIALIZER(struct cmd_dump_mbuf_to_file_result,
> file, NULL);
> +
> +static cmdline_parse_inst_t cmd_dump_mbuf_to_file = {
> +       .f = cmd_dump_mbuf_to_file_parsed,  /* function to call */
> +       .data = NULL,      /* 2nd arg of func */
> +       .help_str = "dump_mbuf_history_all <file_name>: Dump mbuf history
> to file",
> +       .tokens = {        /* token list, NULL terminated */
> +               (void *)&cmd_dump_mbuf_to_file_dump,
> +               (void *)&cmd_dump_mbuf_to_file_file,
> +               NULL,
> +       },
> +};
> +
> +/* Dump single mbuf history */
> +struct cmd_dump_mbuf_history_single_result {
> +       cmdline_fixed_string_t dump;
> +       cmdline_fixed_string_t mbuf_ptr;
> +};
> +
> +static void cmd_dump_mbuf_history_single_parsed(void *parsed_result,
> +               __rte_unused struct cmdline *cl, __rte_unused void *data)
> +{
> +       struct cmd_dump_mbuf_history_single_result *res = parsed_result;
> +       struct rte_mbuf *mbuf;
> +       uintptr_t mbuf_addr;
> +
> +       /* Parse the mbuf pointer from hex string */
> +       if (sscanf(res->mbuf_ptr, "0x%" SCNxPTR, &mbuf_addr) != 1) {
> +               printf("Invalid mbuf pointer format. Use 0x<address>\n");
> +               return;
> +       }
> +
> +       mbuf = (struct rte_mbuf *)mbuf_addr;
> +
> +       printf("Dumping history for mbuf at %p:\n", mbuf);
> +       rte_mbuf_history_dump(stdout, mbuf);
> +}
> +
> +static cmdline_parse_token_string_t cmd_dump_mbuf_history_single_dump =
> +       TOKEN_STRING_INITIALIZER(struct
> cmd_dump_mbuf_history_single_result, dump,
> +                       "dump_mbuf_history_single");
> +
> +static cmdline_parse_token_string_t cmd_dump_mbuf_history_single_ptr =
> +       TOKEN_STRING_INITIALIZER(struct
> cmd_dump_mbuf_history_single_result, mbuf_ptr,
> +                       NULL);
> +
> +static cmdline_parse_inst_t cmd_dump_mbuf_history_single = {
> +       .f = cmd_dump_mbuf_history_single_parsed,
> +       .data = NULL,
> +       .help_str = "dump_mbuf_history_single <mbuf_ptr>: Dump history for
> specific mbuf",
> +       .tokens = {
> +               (void *)&cmd_dump_mbuf_history_single_dump,
> +               (void *)&cmd_dump_mbuf_history_single_ptr,
> +               NULL,
> +       },
> +};
> +
> +/* Dump single mempool history */
> +struct cmd_dump_mbuf_history_single_mempool_result {
> +       cmdline_fixed_string_t dump;
> +       cmdline_fixed_string_t mempool_name;
> +};
> +
> +static void cmd_dump_mbuf_history_single_mempool_parsed(void
> *parsed_result,
> +               __rte_unused struct cmdline *cl, __rte_unused void *data)
> +{
> +       struct cmd_dump_mbuf_history_single_mempool_result *res =
> parsed_result;
> +       struct rte_mempool *mp;
> +
> +       mp = rte_mempool_lookup(res->mempool_name);
> +       if (mp == NULL) {
> +               printf("Mempool '%s' not found\n", res->mempool_name);
> +               return;
> +       }
> +
> +       printf("Dumping history for mempool '%s':\n", res->mempool_name);
> +
> +       rte_mbuf_history_dump_mempool(stdout, mp);
> +}
> +
> +static cmdline_parse_token_string_t
> cmd_dump_mbuf_history_single_mempool_dump =
> +       TOKEN_STRING_INITIALIZER(struct
> cmd_dump_mbuf_history_single_mempool_result,
> +                       dump, "dump_mbuf_history_single_mempool");
> +
> +static cmdline_parse_token_string_t
> cmd_dump_mbuf_history_single_mempool_name =
> +       TOKEN_STRING_INITIALIZER(struct
> cmd_dump_mbuf_history_single_mempool_result,
> +                       mempool_name, NULL);
> +
> +static cmdline_parse_inst_t cmd_dump_mbuf_history_single_mempool = {
> +       .f = cmd_dump_mbuf_history_single_mempool_parsed,
> +       .data = NULL,
> +       .help_str = "dump_mbuf_history_single_mempool <mempool_name>: Dump
> history for specific mempool",
> +       .tokens = {
> +               (void *)&cmd_dump_mbuf_history_single_mempool_dump,
> +               (void *)&cmd_dump_mbuf_history_single_mempool_name,
> +               NULL,
> +       },
> +};
> +
> +/* Dump single mempool history to file only */
> +struct cmd_dump_mbuf_history_single_mempool_to_file_result {
> +       cmdline_fixed_string_t dump;
> +       cmdline_fixed_string_t mempool_name;
> +       cmdline_fixed_string_t file;
> +};
> +
> +static void cmd_dump_mbuf_history_single_mempool_to_file_parsed(void
> *parsed_result,
> +               __rte_unused struct cmdline *cl, __rte_unused void *data)
> +{
> +       struct cmd_dump_mbuf_history_single_mempool_to_file_result *res =
> parsed_result;
> +       struct rte_mempool *mp;
> +       FILE *file = NULL;
> +       char *file_name = res->file;
> +
> +       mp = rte_mempool_lookup(res->mempool_name);
> +       if (mp == NULL) {
> +               printf("Mempool '%s' not found\n", res->mempool_name);
> +               return;
> +       }
> +
> +       if (file_name && strlen(file_name)) {
> +               file = fopen(file_name, "w");
> +               if (!file) {
> +                       printf("Failed to open file '%s'\n", file_name);
> +                       return;
> +               }
> +       } else {
> +               printf("File name required for this command\n");
> +               return;
> +       }
> +
> +       printf("Dumping history for mempool '%s' to file '%s'...\n",
> res->mempool_name, file_name);
> +       rte_mbuf_history_dump_mempool(file, mp);
> +       printf("Mempool history dump finished\n");
> +       fclose(file);
> +}
> +
> +static cmdline_parse_token_string_t
> cmd_dump_mbuf_history_single_mempool_to_file_dump =
> +       TOKEN_STRING_INITIALIZER(struct
> cmd_dump_mbuf_history_single_mempool_to_file_result,
> +                       dump, "dump_mbuf_history_single_mempool");
> +
> +static cmdline_parse_token_string_t
> cmd_dump_mbuf_history_single_mempool_to_file_name =
> +       TOKEN_STRING_INITIALIZER(struct
> cmd_dump_mbuf_history_single_mempool_to_file_result,
> +                       mempool_name, NULL);
> +
> +static cmdline_parse_token_string_t
> cmd_dump_mbuf_history_single_mempool_to_file_file =
> +       TOKEN_STRING_INITIALIZER(struct
> cmd_dump_mbuf_history_single_mempool_to_file_result,
> +                       file, NULL);
> +
> +static cmdline_parse_inst_t cmd_dump_mbuf_history_single_mempool_to_file
> = {
> +       .f = cmd_dump_mbuf_history_single_mempool_to_file_parsed,
> +       .data = NULL,
> +       .help_str = "dump_mbuf_history_single_mempool <mempool_name>
> <file_name>: Dump history for specific mempool to file",
> +       .tokens = {
> +               (void *)&cmd_dump_mbuf_history_single_mempool_to_file_dump,
> +               (void *)&cmd_dump_mbuf_history_single_mempool_to_file_name,
> +               (void *)&cmd_dump_mbuf_history_single_mempool_to_file_file,
> +               NULL,
> +       },
> +};
> +
> +/* Dump all mempools history */
> +struct cmd_dump_mbuf_history_all_result {
> +       cmdline_fixed_string_t dump;
> +};
> +
> +static void cmd_dump_mbuf_history_all_parsed(void *parsed_result,
> +               __rte_unused struct cmdline *cl, __rte_unused void *data)
> +{
> +       __rte_unused struct cmd_dump_mempool_history_all_result *res =
> parsed_result;
> +
> +       printf("Dumping history for all mempools:\n");
> +       rte_mbuf_history_dump_all(stdout);
> +}
> +
> +static cmdline_parse_token_string_t cmd_dump_mbuf_history_all_dump =
> +       TOKEN_STRING_INITIALIZER(struct cmd_dump_mbuf_history_all_result,
> dump,
> +                       "dump_mbuf_history_all");
> +
> +static cmdline_parse_inst_t cmd_dump_mbuf_history_all = {
> +       .f = cmd_dump_mbuf_history_all_parsed,
> +       .data = NULL,
> +       .help_str = "dump_mbuf_history_all: Dump history for all mempools",
> +       .tokens = {
> +               (void *)&cmd_dump_mbuf_history_all_dump,
> +               NULL,
> +       },
> +};
> +
> +
>  /* *** Filters Control *** */
>
>  #define IPV4_ADDR_TO_UINT(ip_addr, ip) \
> @@ -13999,6 +14238,11 @@ static cmdline_parse_ctx_t builtin_ctx[] = {
>         &cmd_cleanup_txq_mbufs,
>         &cmd_dump,
>         &cmd_dump_one,
> +       &cmd_dump_mbuf_to_file,
> +       &cmd_dump_mbuf_history_single,
> +       &cmd_dump_mbuf_history_single_mempool,
> +       &cmd_dump_mbuf_history_single_mempool_to_file,
> +       &cmd_dump_mbuf_history_all,
>         &cmd_flow,
>         &cmd_show_port_meter_cap,
>         &cmd_add_port_meter_profile_srtcm,
> --
> 2.51.0
>
>

--00000000000093c0210640148a07
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Most testpmd commands use spaces not underline as word se=
parator.</div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=
=3D"ltr" class=3D"gmail_attr">On Wed, Oct 1, 2025, 01:39 Thomas Monjalon &l=
t;<a href=3D"mailto:thomas@monjalon.net">thomas@monjalon.net</a>&gt; wrote:=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">From: Shani Per=
etz &lt;<a href=3D"mailto:shperetz@nvidia.com" target=3D"_blank" rel=3D"nor=
eferrer">shperetz@nvidia.com</a>&gt;<br>
<br>
Dump the mbuf history to the console or to a file.<br>
<br>
The dump will contain:<br>
- Operation history for each mbuf<br>
- Summary and statistics about all mbufs<br>
<br>
Dump the history of all mbuf pools:<br>
testpmd&gt; dump_mbuf_history_all<br>
<br>
Dump the history of one mbuf pool:<br>
testpmd&gt; dump_mbuf_history_single_mempool &lt;mempool_name&gt; [file_nam=
e]<br>
<br>
Dump the history of one mbuf:<br>
testpmd&gt; dump_mbuf_history_single<br>
<br>
Signed-off-by: Shani Peretz &lt;<a href=3D"mailto:shperetz@nvidia.com" targ=
et=3D"_blank" rel=3D"noreferrer">shperetz@nvidia.com</a>&gt;<br>
---<br>
=C2=A0app/test-pmd/cmdline.c | 246 ++++++++++++++++++++++++++++++++++++++++=
-<br>
=C2=A01 file changed, 245 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c<br>
index 3731fba370..113db68f8c 100644<br>
--- a/app/test-pmd/cmdline.c<br>
+++ b/app/test-pmd/cmdline.c<br>
@@ -40,6 +40,7 @@<br>
=C2=A0#include &lt;rte_gro.h&gt;<br>
=C2=A0#endif<br>
=C2=A0#include &lt;rte_mbuf_dyn.h&gt;<br>
+#include &lt;rte_mbuf_history.h&gt;<br>
=C2=A0#include &lt;rte_trace.h&gt;<br>
<br>
=C2=A0#include &lt;cmdline_rdline.h&gt;<br>
@@ -296,6 +297,15 @@ static void cmd_help_long_parsed(void *parsed_result,<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &quot;dump_log_types\n&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &quot;=C2=A0 =C2=A0 Dumps the log level for all the dpdk modules=
\n\n&quot;<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&quot;dump_mbuf_history_all\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&quot;=C2=A0 =C2=A0 Dumps the mbuf history for all mempools\n\n&q=
uot;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&quot;dump_mbuf_history_single &lt;mbuf_ptr&gt;\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&quot;=C2=A0 =C2=A0 Dumps the history for a specific mbuf (use 0x=
&lt;address&gt; format)\n\n&quot;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&quot;dump_mbuf_history_single_mempool &lt;mempool_name&gt; [file=
_name]\n&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&quot;=C2=A0 =C2=A0 Dumps the history for a specific mempool\n\n&=
quot;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &quot;show port (port_id) speed_lanes capabilities&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0Show speed lanes capabilities o=
f a port.\n\n&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 );<br>
@@ -9177,6 +9187,8 @@ static void cmd_dump_parsed(void *parsed_result,<br>
=C2=A0#endif<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 else if (!strcmp(res-&gt;dump, &quot;dump_log_t=
ypes&quot;))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rte_log_dump(stdout=
);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0else if (!strcmp(res-&gt;dump, &quot;dump_mbuf_=
history_all&quot;))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rte_mbuf_history_du=
mp_all(stdout);<br>
=C2=A0}<br>
<br>
=C2=A0static cmdline_parse_token_string_t cmd_dump_dump =3D<br>
@@ -9198,7 +9210,8 @@ cmd_dump_init(void)<br>
=C2=A0#ifndef RTE_EXEC_ENV_WINDOWS<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;dump_trace#&q=
uot;<br>
=C2=A0#endif<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;dump_log_type=
s&quot;;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;dump_log_type=
s#&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;dump_mbuf_his=
tory&quot;;<br>
=C2=A0}<br>
<br>
=C2=A0static cmdline_parse_inst_t cmd_dump =3D {<br>
@@ -9260,6 +9273,232 @@ static cmdline_parse_inst_t cmd_dump_one =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
=C2=A0};<br>
<br>
+/* Dump mbuf history to file */<br>
+struct cmd_dump_mbuf_to_file_result {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0cmdline_fixed_string_t dump;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0cmdline_fixed_string_t file;<br>
+};<br>
+<br>
+static void cmd_dump_mbuf_to_file_parsed(void *parsed_result,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct cmdline *cl,=
 __rte_unused void *data)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct cmd_dump_mbuf_to_file_result *res =3D pa=
rsed_result;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0FILE *file =3D stdout;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0char *file_name =3D res-&gt;file;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (strcmp(res-&gt;dump, &quot;dump_mbuf_histor=
y_all&quot;)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cmdline_printf(cl, =
&quot;Invalid dump type\n&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (file_name &amp;&amp; strlen(file_name)) {<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0file =3D fopen(file=
_name, &quot;w&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!file) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0rte_mbuf_history_dump_all(stdout);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rte_mbuf_history_dump_all(file);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0printf(&quot;Flow dump finished\n&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (file_name &amp;&amp; strlen(file_name))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fclose(file);<br>
+}<br>
+<br>
+static cmdline_parse_token_string_t cmd_dump_mbuf_to_file_dump =3D<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0TOKEN_STRING_INITIALIZER(struct cmd_dump_mbuf_t=
o_file_result, dump,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&quot;dump_mbuf_history_all&quot;);<br>
+<br>
+static cmdline_parse_token_string_t cmd_dump_mbuf_to_file_file =3D<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0TOKEN_STRING_INITIALIZER(struct cmd_dump_mbuf_t=
o_file_result, file, NULL);<br>
+<br>
+static cmdline_parse_inst_t cmd_dump_mbuf_to_file =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.f =3D cmd_dump_mbuf_to_file_parsed,=C2=A0 /* f=
unction to call */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.data =3D NULL,=C2=A0 =C2=A0 =C2=A0 /* 2nd arg =
of func */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.help_str =3D &quot;dump_mbuf_history_all &lt;f=
ile_name&gt;: Dump mbuf history to file&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.tokens =3D {=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* tok=
en list, NULL terminated */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(void *)&amp;cmd_du=
mp_mbuf_to_file_dump,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(void *)&amp;cmd_du=
mp_mbuf_to_file_file,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0},<br>
+};<br>
+<br>
+/* Dump single mbuf history */<br>
+struct cmd_dump_mbuf_history_single_result {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0cmdline_fixed_string_t dump;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0cmdline_fixed_string_t mbuf_ptr;<br>
+};<br>
+<br>
+static void cmd_dump_mbuf_history_single_parsed(void *parsed_result,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__rte_unused struct=
 cmdline *cl, __rte_unused void *data)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct cmd_dump_mbuf_history_single_result *res=
 =3D parsed_result;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct rte_mbuf *mbuf;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uintptr_t mbuf_addr;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Parse the mbuf pointer from hex string */<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (sscanf(res-&gt;mbuf_ptr, &quot;0x%&quot; SC=
NxPTR, &amp;mbuf_addr) !=3D 1) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0printf(&quot;Invali=
d mbuf pointer format. Use 0x&lt;address&gt;\n&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0mbuf =3D (struct rte_mbuf *)mbuf_addr;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0printf(&quot;Dumping history for mbuf at %p:\n&=
quot;, mbuf);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rte_mbuf_history_dump(stdout, mbuf);<br>
+}<br>
+<br>
+static cmdline_parse_token_string_t cmd_dump_mbuf_history_single_dump =3D<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0TOKEN_STRING_INITIALIZER(struct cmd_dump_mbuf_h=
istory_single_result, dump,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&quot;dump_mbuf_history_single&quot;);<br>
+<br>
+static cmdline_parse_token_string_t cmd_dump_mbuf_history_single_ptr =3D<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0TOKEN_STRING_INITIALIZER(struct cmd_dump_mbuf_h=
istory_single_result, mbuf_ptr,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0NULL);<br>
+<br>
+static cmdline_parse_inst_t cmd_dump_mbuf_history_single =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.f =3D cmd_dump_mbuf_history_single_parsed,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.data =3D NULL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.help_str =3D &quot;dump_mbuf_history_single &l=
t;mbuf_ptr&gt;: Dump history for specific mbuf&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.tokens =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(void *)&amp;cmd_du=
mp_mbuf_history_single_dump,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(void *)&amp;cmd_du=
mp_mbuf_history_single_ptr,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0},<br>
+};<br>
+<br>
+/* Dump single mempool history */<br>
+struct cmd_dump_mbuf_history_single_mempool_result {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0cmdline_fixed_string_t dump;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0cmdline_fixed_string_t mempool_name;<br>
+};<br>
+<br>
+static void cmd_dump_mbuf_history_single_mempool_parsed(void *parsed_resul=
t,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__rte_unused struct=
 cmdline *cl, __rte_unused void *data)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct cmd_dump_mbuf_history_single_mempool_res=
ult *res =3D parsed_result;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct rte_mempool *mp;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0mp =3D rte_mempool_lookup(res-&gt;mempool_name)=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (mp =3D=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0printf(&quot;Mempoo=
l &#39;%s&#39; not found\n&quot;, res-&gt;mempool_name);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0printf(&quot;Dumping history for mempool &#39;%=
s&#39;:\n&quot;, res-&gt;mempool_name);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rte_mbuf_history_dump_mempool(stdout, mp);<br>
+}<br>
+<br>
+static cmdline_parse_token_string_t cmd_dump_mbuf_history_single_mempool_d=
ump =3D<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0TOKEN_STRING_INITIALIZER(struct cmd_dump_mbuf_h=
istory_single_mempool_result,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0dump, &quot;dump_mbuf_history_single_mempool&quot;);<br>
+<br>
+static cmdline_parse_token_string_t cmd_dump_mbuf_history_single_mempool_n=
ame =3D<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0TOKEN_STRING_INITIALIZER(struct cmd_dump_mbuf_h=
istory_single_mempool_result,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0mempool_name, NULL);<br>
+<br>
+static cmdline_parse_inst_t cmd_dump_mbuf_history_single_mempool =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.f =3D cmd_dump_mbuf_history_single_mempool_par=
sed,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.data =3D NULL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.help_str =3D &quot;dump_mbuf_history_single_me=
mpool &lt;mempool_name&gt;: Dump history for specific mempool&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.tokens =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(void *)&amp;cmd_du=
mp_mbuf_history_single_mempool_dump,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(void *)&amp;cmd_du=
mp_mbuf_history_single_mempool_name,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0},<br>
+};<br>
+<br>
+/* Dump single mempool history to file only */<br>
+struct cmd_dump_mbuf_history_single_mempool_to_file_result {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0cmdline_fixed_string_t dump;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0cmdline_fixed_string_t mempool_name;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0cmdline_fixed_string_t file;<br>
+};<br>
+<br>
+static void cmd_dump_mbuf_history_single_mempool_to_file_parsed(void *pars=
ed_result,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__rte_unused struct=
 cmdline *cl, __rte_unused void *data)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct cmd_dump_mbuf_history_single_mempool_to_=
file_result *res =3D parsed_result;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct rte_mempool *mp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0FILE *file =3D NULL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0char *file_name =3D res-&gt;file;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0mp =3D rte_mempool_lookup(res-&gt;mempool_name)=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (mp =3D=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0printf(&quot;Mempoo=
l &#39;%s&#39; not found\n&quot;, res-&gt;mempool_name);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (file_name &amp;&amp; strlen(file_name)) {<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0file =3D fopen(file=
_name, &quot;w&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!file) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0printf(&quot;Failed to open file &#39;%s&#39;\n&quot;, file_name)=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0printf(&quot;File n=
ame required for this command\n&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0printf(&quot;Dumping history for mempool &#39;%=
s&#39; to file &#39;%s&#39;...\n&quot;, res-&gt;mempool_name, file_name);<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rte_mbuf_history_dump_mempool(file, mp);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0printf(&quot;Mempool history dump finished\n&qu=
ot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fclose(file);<br>
+}<br>
+<br>
+static cmdline_parse_token_string_t cmd_dump_mbuf_history_single_mempool_t=
o_file_dump =3D<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0TOKEN_STRING_INITIALIZER(struct cmd_dump_mbuf_h=
istory_single_mempool_to_file_result,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0dump, &quot;dump_mbuf_history_single_mempool&quot;);<br>
+<br>
+static cmdline_parse_token_string_t cmd_dump_mbuf_history_single_mempool_t=
o_file_name =3D<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0TOKEN_STRING_INITIALIZER(struct cmd_dump_mbuf_h=
istory_single_mempool_to_file_result,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0mempool_name, NULL);<br>
+<br>
+static cmdline_parse_token_string_t cmd_dump_mbuf_history_single_mempool_t=
o_file_file =3D<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0TOKEN_STRING_INITIALIZER(struct cmd_dump_mbuf_h=
istory_single_mempool_to_file_result,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0file, NULL);<br>
+<br>
+static cmdline_parse_inst_t cmd_dump_mbuf_history_single_mempool_to_file =
=3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.f =3D cmd_dump_mbuf_history_single_mempool_to_=
file_parsed,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.data =3D NULL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.help_str =3D &quot;dump_mbuf_history_single_me=
mpool &lt;mempool_name&gt; &lt;file_name&gt;: Dump history for specific mem=
pool to file&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.tokens =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(void *)&amp;cmd_du=
mp_mbuf_history_single_mempool_to_file_dump,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(void *)&amp;cmd_du=
mp_mbuf_history_single_mempool_to_file_name,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(void *)&amp;cmd_du=
mp_mbuf_history_single_mempool_to_file_file,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0},<br>
+};<br>
+<br>
+/* Dump all mempools history */<br>
+struct cmd_dump_mbuf_history_all_result {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0cmdline_fixed_string_t dump;<br>
+};<br>
+<br>
+static void cmd_dump_mbuf_history_all_parsed(void *parsed_result,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__rte_unused struct=
 cmdline *cl, __rte_unused void *data)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__rte_unused struct cmd_dump_mempool_history_al=
l_result *res =3D parsed_result;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0printf(&quot;Dumping history for all mempools:\=
n&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rte_mbuf_history_dump_all(stdout);<br>
+}<br>
+<br>
+static cmdline_parse_token_string_t cmd_dump_mbuf_history_all_dump =3D<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0TOKEN_STRING_INITIALIZER(struct cmd_dump_mbuf_h=
istory_all_result, dump,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&quot;dump_mbuf_history_all&quot;);<br>
+<br>
+static cmdline_parse_inst_t cmd_dump_mbuf_history_all =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.f =3D cmd_dump_mbuf_history_all_parsed,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.data =3D NULL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.help_str =3D &quot;dump_mbuf_history_all: Dump=
 history for all mempools&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.tokens =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(void *)&amp;cmd_du=
mp_mbuf_history_all_dump,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0},<br>
+};<br>
+<br>
+<br>
=C2=A0/* *** Filters Control *** */<br>
<br>
=C2=A0#define IPV4_ADDR_TO_UINT(ip_addr, ip) \<br>
@@ -13999,6 +14238,11 @@ static cmdline_parse_ctx_t builtin_ctx[] =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;cmd_cleanup_txq_mbufs,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;cmd_dump,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;cmd_dump_one,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;cmd_dump_mbuf_to_file,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;cmd_dump_mbuf_history_single,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;cmd_dump_mbuf_history_single_mempool,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;cmd_dump_mbuf_history_single_mempool_to_fi=
le,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;cmd_dump_mbuf_history_all,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;cmd_flow,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;cmd_show_port_meter_cap,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;cmd_add_port_meter_profile_srtcm,<br>
-- <br>
2.51.0<br>
<br>
</blockquote></div>

--00000000000093c0210640148a07--
